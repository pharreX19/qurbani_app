import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/questions_and_names_controller.dart';
import 'package:qurbani/widgets/common/custom_app_bar.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class NewQuestionNameDetail extends StatelessWidget {
  final DocumentSnapshot newQuestion;

  NewQuestionNameDetail({this.newQuestion});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar().build(context),
        body: MainLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User feedback and questions'),
              SizedBox(height: SizeConfig.blockSizeVertical * 5,),
              Text(newQuestion['message']),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Submitted by ${newQuestion['contact']}'),
                   SizedBox(height: SizeConfig.blockSizeVertical * 0.5,),
                   Text('${DateTime.fromMillisecondsSinceEpoch(newQuestion['created_at'].seconds * 1000)}')
                 ],
             ),
              )
            ],
          )
        )
      ),
    );
  }
}
