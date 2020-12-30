import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/feedback_controller.dart';
import 'package:qurbani/screens/feedback/admin/feedback_detail.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Feedback extends StatelessWidget {
  final FeedbackController _questionsAndNamesController = Get.put(FeedbackController());

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 3),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            Text(
              "Complete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeVertical * 5
                      ),
                      child: Text('User feedback and questions')),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  StreamBuilder(
                      stream: Get.find<FeedbackController>().feedback,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('An error occurred, please try again later!'));
                        }
                        if (snapshot.hasData) {
                          List<dynamic> feedbackList = snapshot.data.documents;
                          return Expanded(
                              child: ListView.builder(
                                itemCount: feedbackList.length,
                                itemBuilder: (context, int index) {
                                  DocumentSnapshot feedback = feedbackList[index];
                                  return Dismissible(
                                    key: Key(feedback.id),
                                    direction: DismissDirection.startToEnd,
                                    background: slideRightBackground(),
                                    onDismissed: (dismissDirection) {
                                      Get.find<FeedbackController>().updateFeedback(feedback.id);
                                      },
                                    // secondaryBackground: slideRightBackground(),
                                    child: ListTile(
                                      title: Text(feedback['message'],
                                        maxLines: 2, overflow: TextOverflow.ellipsis,),
                                      subtitle: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: 'Submitted by  ', style: TextStyle(fontStyle: FontStyle.italic)),
                                            TextSpan(text: feedback['contact'])
                                          ]
                                        )
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_rounded, size: SizeConfig
                                          .blockSizeHorizontal * 5,),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => FeedbackDetail(
                                                  newQuestion: feedback,
                                                )));
                                      },
                                    ),
                                  );
                                },
                              )
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                  ),
                ],
          ),
        ),
    );
  }
}
