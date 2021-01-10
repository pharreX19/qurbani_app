import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/requests/admin/request_approve_reject_card.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class RequestDetail extends StatelessWidget {
  final dynamic document;

  RequestDetail({this.document});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.teal),
        ),
        body: MainLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${document['user']['name']}\'s Request'),
              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
              Container(
                height: SizeConfig.blockSizeVertical * 26,
                child: RequestApproveRejectCard(
                  isSelected: false,
                  document: document,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
