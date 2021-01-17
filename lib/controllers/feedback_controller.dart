import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/services/api_service.dart';

class FeedbackController extends GetxController{
  final Query feedbackCollection = FirebaseFirestore.instance.collection('feedbacks');
//  RxString questionOrNamesFieldError = ''.obs;
// RxString questionOrNamesFieldError = ''.obs;
//  String questionOrName = '';

//  @override
//  void onClose(){
//    textEditingController.dispose();
//  }


  Stream<QuerySnapshot> get feedback {
    return feedbackCollection.where('is_complete',isEqualTo: false).snapshots();
  }

  Future<void> updateFeedback(String id) async{
    // print(id);
    dynamic response = await ApiService.instance.updateFeedback('feedback/$id', {
      'is_complete' : true
    });
  }

//  void setQuestionOrName(String value){
//    if(value.trim().isEmpty){
//      questionOrNamesFieldError.value = 'Please fill out this field';
//    }else{
//      questionOrNamesFieldError.value = '';
//    }
//    questionOrName = value;
//  }

  void onSubmit(BuildContext context, String message, Function callback) async{
//    setQuestionOrName(questionOrName);
//    if(message.trim().isEmpty){
//      questionOrNamesFieldError.value = 'Please fill out this field';
//    }else{
      try{
        // questionOrNamesFieldError.value = '';
        dynamic response = await ApiService.instance.createFeedback('feedback', {
          'contact': Get.find<DashboardController>().contactNo,
          'message': message
        });
//        message = '';
//        textEditingController.text = '';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Submitted successfully!'),));
        callback();
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred, please try again!'),));
      }
    }
//  }
}
