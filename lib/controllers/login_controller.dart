import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactNumberController =  TextEditingController();
  RxString fullNameFieldError = ''.obs;
  RxString contactNumberFieldError = ''.obs;
  RxBool isSubmitting = false.obs;

  @override
  void dispose() {
    fullNameController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }

  void onSubmitLogin(){
    print('FROM controller ${fullNameController.text}');
    onChangedFullNameTextField(fullNameController.text);
    onChangedContactNumberTextField(contactNumberController.text);

    if(fullNameFieldError.value.isEmpty && contactNumberFieldError.value.isEmpty){
      isSubmitting.value = true;
      Future.delayed(Duration(seconds: 3), (){
        isSubmitting.value = false;
      });
    }
  }

  void onChangedFullNameTextField(String value){
    if(value.trim().isEmpty){
      fullNameFieldError.value = 'Name is required!';
    }
    else{
      fullNameFieldError.value = '';
    }
  }

  void onChangedContactNumberTextField(String value) {
    if (value.trim().isEmpty) {
      contactNumberFieldError.value = 'Contact number is required!';
    } else {
      contactNumberFieldError.value = '';
    }
  }
}