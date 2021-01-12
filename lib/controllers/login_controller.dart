import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qurbani/screens/home.dart';

class LoginController extends GetxController{
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactNumberController =  TextEditingController();
  final MethodChannel _methodChannel = MethodChannel('flutter/qurbani_app');
  RxString fullNameFieldError = ''.obs;
  RxString contactNumberFieldError = ''.obs;
  RxBool isSubmitting = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool _manualCodeEnter = false.obs;
  String _verificationId;
  String contactNumber;

  @override
  void onInit() {
    super.onInit();
    fetchPhoneNumber();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }

  Future<void> fetchPhoneNumber() async {
    isSubmitting.value = true;
    Future.delayed(Duration(seconds: 2), () async {
    try{
      Map<String, String> phoneNumberDetails = await _methodChannel.invokeMapMethod("fetchContactNumber");
      print(phoneNumberDetails);
      if(phoneNumberDetails['phone_number'].trim() != null || phoneNumberDetails['phone_number'].trim().isNotEmpty){
        contactNumberController.text = phoneNumberDetails['phone_number'];
      }
    }on PlatformException catch(e){
      print('Exception occurred $e');
    }finally{
      isSubmitting.value = false;
      print('Contact Number is $contactNumber');
    }
    });
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

  void onSubmitLogin(BuildContext context) async{
    print('FROM controller ${fullNameController.text}');
    // onChangedFullNameTextField(fullNameController.text);
    onChangedContactNumberTextField(contactNumberController.text);

    if(/*fullNameFieldError.value.isEmpty &&*/ contactNumberFieldError.value.isEmpty){
      isSubmitting.value = true;
      await auth.verifyPhoneNumber(
        phoneNumber: '+9607700601',
        verificationCompleted:  (context) => verificationCompleted, //(PhoneAuthCredential credential) {},
        verificationFailed: verificationFailed, //(FirebaseAuthException e) {},
        codeSent: verificationCodeSent, //(String verificationId, int resendToken) {},
        codeAutoRetrievalTimeout: verificationCodeAutoRetrievalTimeout, //(String verificationId) {},
        timeout: const Duration(seconds: 5)
      );
      print('Veruifical method clalled');
    }
  }

  void verificationCompleted(BuildContext context, PhoneAuthCredential credential) async{
    UserCredential userCredential = await auth.signInWithCredential(credential);
    User authUser = userCredential.user;
    if(authUser != null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
    print('SIGNED IN SUCCESS automatically');
  }

  void verificationFailed(FirebaseAuthException e) {
    print('AN ERROR OCCURED $e');
  }

  void verificationCodeSent(String verificationId, int resendToken) async{
    print('Verification ID $verificationId');
    print('resend token $resendToken');
    _manualCodeEnter.value = true;
    _verificationId =  verificationId;
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

  void onTokenVerificationSubmit(BuildContext context)async {
    print('manual verification happens here!');
    final PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: '1234');
    verificationCompleted(context, phoneAuthCredential);
    // final UserCredential userCredential = await auth.signInWithCredential(credential);

  }
}