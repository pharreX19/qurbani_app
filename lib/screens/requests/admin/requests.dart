import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/requests_controller.dart';
import 'package:qurbani/providers/completed_service_visibility_provider.dart';
import 'package:qurbani/screens/requests/admin/request_approve_reject_card.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Requests extends StatefulWidget {
  final RequestsController _requestsController = Get.put(RequestsController());
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  List<Icon> _toggleButtonIcons = [
    Icon(Icons.playlist_play),
    Icon(Icons.playlist_add_check),
  ];
  List<QueryDocumentSnapshot> pendingRequests;
  List<QueryDocumentSnapshot> approvedRequests;
  List<QueryDocumentSnapshot> completedRequests;
  CompletedServiceVisibilityProvider _completedServiceVisibility;

  List<bool> _isSelected = [true, false];

  Widget _buildRequestList(List<QueryDocumentSnapshot> documents) {
      if(documents.length == 0){
        return Expanded(
          child: Center(
            child: Text('No ${_isSelected[0] ? 'pending' : 'approved' } requests found!'),
          ),
        );
      }
      return Expanded(
        child: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, int index) {
            return RequestApproveRejectCard(isSelected: _isSelected[0], document: documents[index]);
          },
        ),
      );
  }

  void _populateRequestCategories(AsyncSnapshot snapshot){
    pendingRequests = [];
    approvedRequests = [];
    completedRequests = [];
    snapshot.data.documents.forEach((document){
      var data = document.data();
      switch(data['status'].toString().toLowerCase()){
        case 'pending':
          pendingRequests.add(document);
          break;

        case 'approved':
          approvedRequests.add(document);
          break;

        case 'completed':
          completedRequests.add(document);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _completedServiceVisibility = Provider.of<CompletedServiceVisibilityProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MainLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Requests'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Center(
                child: ToggleButtons(
                  constraints: BoxConstraints(
                      maxHeight: SizeConfig.blockSizeVertical * 4,
                      minWidth: SizeConfig.blockSizeHorizontal * 46),
                  children: _toggleButtonIcons,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
                        if (buttonIndex == index) {
                          _isSelected[buttonIndex] = true;
                        } else {
                          _isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: _isSelected,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
              StreamBuilder(
                stream: Get.find<RequestsController>().requests,
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text('An error occurred, please try again later'),
                    );
                  }
                  if(snapshot.hasData){
                    _populateRequestCategories(snapshot);
                    return _isSelected[0] ? _buildRequestList(pendingRequests) :
                        _completedServiceVisibility.hideCompleted ? _buildRequestList(approvedRequests) :
                        _buildRequestList([...approvedRequests, ...completedRequests]);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
