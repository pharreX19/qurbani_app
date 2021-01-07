import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/requests_controller.dart';
import 'package:qurbani/screens/media/request_service_media.dart';
import 'package:qurbani/screens/requests/user/request_page_view.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Requests extends StatefulWidget {
  final RequestsController _requestsController = Get.put(RequestsController());
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  PageController _pageController = PageController(viewportFraction: 0.9);
  var _currentPageValue = 0.0;
  List<QueryDocumentSnapshot> userRequests;

  List<Map<String, dynamic>> populateCompletedAndPendingUserRequests(){
    final List<Map<String, dynamic>> requestStats = [
      {'title': 'Pending', 'icon': Icons.bar_chart, 'count': 0},
      {'title': 'Completed', 'icon': Icons.insert_chart_outlined, 'count': 0},
      {'title': 'Rejected', 'icon': Icons.error_outline, 'count': 0}
    ];

    userRequests.forEach((element) {
      if(element['status'].toString().toLowerCase() == 'pending' || element['status'].toString().toLowerCase() == 'approved'){
        requestStats[0]['count'] += 1;
      }
      else if(element['status'].toString().toLowerCase() == 'completed'){
        requestStats[1]['count'] += 1;
      }
      else if(element['status'].toString().toLowerCase() == 'rejected'){
        requestStats[2]['count'] += 1;
      }
    });
    return requestStats;
  }

  Widget _buildRequestStats(){
      return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: populateCompletedAndPendingUserRequests().map((element){
            return Column(
              children: [
                Row(
                  children: [
                    Text(element['count'].toString()),
                    Icon(element['icon']),
                  ],
                ),
                Text(element['title'])
              ],
            );
          }).toList()
      );
  }

  Widget _buildRequestList() {
    if(userRequests.length == 0){
      return Expanded(
        child: Center(
          child: Text('No requests found!'),
        ),
      );
    }
    return Expanded(
      child: PageView.builder(
      controller: _pageController,
      physics: BouncingScrollPhysics(),
      itemCount: userRequests.length,
        itemBuilder: (context, int index){
        if(index == _currentPageValue.floor() + 1){
          return Transform(
            transform: Matrix4.identity()..rotateX(_currentPageValue - index),
              child: RequestPageView(document: userRequests[index],)
          );
        }
        else{
          return InkWell(
            onTap: (){
              if(_currentPageValue == index && userRequests[index]['status'].toString().toLowerCase() == 'approved' ){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    RequestServiceMedia(mediaStream: userRequests[index].reference.collection('images').snapshots(),
                      title: {
                      'name': userRequests[index]['user']['name'],
                        'type': userRequests[index]['service']['name'],
                      },)));
              }
            },
            child: Transform(
                transform: Matrix4.identity()..rotateX(_currentPageValue - index),
                child: RequestPageView(document: userRequests[index],)

            ),
          );
        }
        },
      ),
    );
  }
  
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MainLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Requests'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              StreamBuilder(
                stream: Get.find<RequestsController>().userRequests,
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.hasError){
                    return Expanded(
                      child: Center(
                        child: Text('An error occurred, please try again later'),
                      ),
                    );
                  }
                  if(snapshot.hasData){
                    userRequests = snapshot.data.documents;
                    print(userRequests);
                    return Expanded(
                      child: Column(
                        children: [
                          _buildRequestStats(),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                          _buildRequestList(),
                        ],
                      ),
                    );
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
