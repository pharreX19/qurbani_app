import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactNumberController =  TextEditingController();
  RxString fullNameFieldError = ''.obs;
  RxString contactNumberFieldError = ''.obs;
  RxBool isSubmitting = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    fullNameController.dispose();
    contactNumberController.dispose();
    super.dispose();
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

  void onSubmitLogin() async{
    print('FROM controller ${fullNameController.text}');
    onChangedFullNameTextField(fullNameController.text);
    onChangedContactNumberTextField(contactNumberController.text);

    if(fullNameFieldError.value.isEmpty && contactNumberFieldError.value.isEmpty){
      isSubmitting.value = true;
      await auth.verifyPhoneNumber(
        phoneNumber: '+9607700601',
        verificationCompleted:  verificationCompleted, //(PhoneAuthCredential credential) {},
        verificationFailed: verificationFailed, //(FirebaseAuthException e) {},
        codeSent: verificationCodeSent, //(String verificationId, int resendToken) {},
        codeAutoRetrievalTimeout: verificationCodeAutoRetrievalTimeout, //(String verificationId) {},
        timeout: const Duration(seconds: 5)
      );
      print('Veruifical method clalled');
    }
  }

  void verificationCompleted(PhoneAuthCredential credential) async{
    await auth.signInWithCredential(credential);
    print('SIGNED IN SUCCESS automatically');
  }

  void verificationFailed(FirebaseAuthException e) {
    print('AN ERROR OCCURED $e');
  }

  void verificationCodeSent(String verificationId, int resendToken) async{
    print('Verification ID $verificationId');
    print('resend token $resendToken');
  }

  void verificationCodeAutoRetrievalTimeout(String verificationId) {
    print('Retrieeval code $verificationId');
  }

  void signInWithPhoneNumber(String verificationId, String smsCode)async{
    try{
      final AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      final User user = (await auth.signInWithCredential(credential)).user;
      print('COOl, finally logged iN');
    }catch(e){
      print('Error Logging in User and error is $e');
    }
  }
}