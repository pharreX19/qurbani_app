import 'package:get/get.dart';

class QuestionsAndNamesController extends GetxController{
  RxString questionOrNamesFieldError = ''.obs;
  String questionOrName = '';

  void setQuestionOrName(String value){
    if(value.trim().isEmpty){
      questionOrNamesFieldError.value = 'Please fill out this field';
    }else{
      questionOrNamesFieldError.value = '';
    }
    questionOrName = value;
  }

  void onSubmit(){
    if(questionOrName.isEmpty){
      questionOrNamesFieldError.value = 'Please fill out this field';
    }else{
      print(questionOrName);
      print('Submitting');
    }
  }
}