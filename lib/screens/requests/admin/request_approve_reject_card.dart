import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/requests_controller.dart';
import 'package:qurbani/screens/requests/admin/request_approve_reject_button.dart';
import 'package:qurbani/screens/requests/admin/request_options_bottom_sheet.dart';

class RequestApproveRejectCard extends StatelessWidget {
  final bool isSelected;
  // final int index;
  final QueryDocumentSnapshot document;
  RequestApproveRejectCard({this.isSelected, this.document});

  Widget _buildOptionButtons(BuildContext context){
    if(isSelected){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RequestApproveRejectButton(
              title: 'Approve',
              icon: Icons.check,
              color: Colors.teal,
              onPressed: () {
                Get.find<RequestsController>().updateRequestStatus(context, document.id, 'approved');
              }),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 2,
          ),
          RequestApproveRejectButton(
              title: 'Reject',
              icon: Icons.close,
              color: Colors.red,
              onPressed: () {
                Get.find<RequestsController>().updateRequestStatus(context, document.id, 'rejected');
              }),
        ],
      );
    }else {
      return document['status'].toString().toLowerCase() == 'completed' ?  //Get.find<RequestsController>().requests[index]['status'].toString() == 'completed' ?
      Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.5),
        child: Align(
          alignment: Alignment.centerRight,
            child: Text('Completed', style: TextStyle(color: Colors.teal),)),
      ) :
      Row(
        children: [
          RequestApproveRejectButton(
              title: 'Complete',
              icon: Icons.done_all,
              color: Colors.teal,
              onPressed: () {
                Get.find<RequestsController>().updateRequestStatus(context, document.id, 'completed');
              }),
        ],
      );
    }
  }

  Widget _buildMoreIconButton(BuildContext context){
    return Positioned(
      right: -5,
      top: 0,
      child: isSelected || document['status'].toString().toLowerCase() == 'completed' ? Container() :
      IconButton(
         icon: Icon(Icons.more_vert),
        onPressed: () {
           showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
              context: context, builder: (context){
            return RequestOptionsBottomSheet(receiptUrl:  document.data()['receipt_url']);
          });
        },
      ),
    );
  }

  Widget _buildCardContent(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(document['user']['name']),//Get.find<RequestsController>().requests[index]['user']['name']),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        Text(document['service']['name']),//Get.find<RequestsController>().requests[index]['service']['name']),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 1),
          child: Text('Quantity ${document['quantity']}'),//${Get.find<RequestsController>().requests[index]['quantity']}'),
        ),
        Text(DateTime.fromMillisecondsSinceEpoch(document['date'].seconds * 1000).toString()),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        _buildOptionButtons(context)
      ],
    );
  }

  Widget _buildMainCard(BuildContext context){
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeConfig.blockSizeVertical * 2,
      ),
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeHorizontal * 3,
          horizontal: SizeConfig.blockSizeHorizontal * 5),
      width: SizeConfig.blockSizeHorizontal * 100,
      decoration: BoxDecoration(
          color: document['status'] == 'completed' ?  //Get.find<RequestsController>().requests[index]['status'] == 'completed' ?
          Colors.teal[50] : Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: document['status'] == 'completed' ?//Get.find<RequestsController>().requests[index]['status'] == 'completed' ?
          Colors.teal[50] : Colors.grey[300])),
      child: _buildCardContent(context)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMainCard(context),
        _buildMoreIconButton(context)
      ],
    );
  }
}
