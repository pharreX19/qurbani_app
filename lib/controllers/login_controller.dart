import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/screens/authentication/user/token.dart';
import 'package:qurbani/screens/home.dart';
import 'package:qurbani/services/api_service.dart';
import 'package:qurbani/services/secure_storage.dart';

class LoginController extends GetxController{
  // final TextEditingController fullNameController = TextEditingController();
  // final TextEditingController contactNumberController =  TextEditingController();
  // final TextEditingController passwordController =  TextEditingController();
  // final TextEditingController emailController =  TextEditingController();

  final MethodChannel _methodChannel = MethodChannel('flutter/qurbani_app');

  // RxString fullNameFieldError = ''.obs;
  // RxString contactNumberFieldError = ''.obs;
  // RxString emailFieldError = ''.obs;
  // RxString passwordFieldError = ''.obs;
  RxString phoneNumberCountryCode = ''.obs;

  RxBool isSubmitting = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool _manualCodeEnter = false.obs;
  String _verificationId;
  RxString contactNumber = 'Contact Number'.obs;

  RxString loginError = RxString();
  BuildContext buildContext;

  @override
  void onInit() {
    super.onInit();
    fetchPhoneNumber();
  }

  loadPhoneCountryCodeJson(String country) async{
    print('CALLING JSON');
    String data = await rootBundle.loadString('assets/country_codes.json');
    var result = jsonDecode(data);
    // print(result);
    result.forEach((element){
      if(element['code'].toString().toLowerCase() == country){
        phoneNumberCountryCode.value = element['dial_code'];
      }
    });

  }

  // @override
  // void dispose() {
    // fullNameController.dispose();
    // contactNumberController.dispose();
    // emailController.dispose();
    // passwordController.dispose();
    // super.dispose();
  // }

  Future<void> fetchPhoneNumber() async {
    isSubmitting.value = true;
    Future.delayed(Duration(seconds: 2), () async {
    try{
      Map<String, String> phoneNumberDetails = await _methodChannel.invokeMapMethod("fetchContactNumber");
      print(phoneNumberDetails);
      if(phoneNumberDetails['phone_number'].trim() != null || phoneNumberDetails['phone_number'].trim().isNotEmpty){
        /*contactNumberController.text*/ contactNumber.value = phoneNumberDetails['phone_number'];
        await loadPhoneCountryCodeJson(phoneNumberDetails['country']);
        // phoneNumberCountryCode.value = '+960';
      }
    }on PlatformException catch(e){
      print('Exception occurred $e');
    }finally{
      isSubmitting.value = false;
      print('Contact Number is $contactNumber');
    }
    });
  }


  // void onChangedFullNameTextField(String value){
  //   if(value.trim().isEmpty){
  //     fullNameFieldError.value = 'Name is required!';
  //   }
  //   else{
  //     fullNameFieldError.value = '';
  //   }
  // }
  //
  // void onChangedContactNumberTextField(String value) {
  //   if (value.trim().isEmpty) {
  //     contactNumberFieldError.value = 'Contact number is required!';
  //   } else {
  //     contactNumberFieldError.value = '';
  //   }
  // }
  //
  // void onChangedEmailTextField(String value){
  //   if(value.trim().isEmpty){
  //     fullNameFieldError.value = 'Email is required!';
  //   }
  //   else{
  //     fullNameFieldError.value = '';
  //   }
  // }
  //
  // void onChangedPasswordTextField(String value){
  //   if(value.trim().isEmpty){
  //     fullNameFieldError.value = 'Password is required!';
  //   }
  //   else{
  //     fullNameFieldError.value = '';
  //   }
  // }

  void onSubmitAdminLogin(BuildContext context, Map<String, dynamic> credentials, Function callback) async{
    try{
      // print(credentials);

      isSubmitting.value = true;
      String fbToken = await SecureStorage.instance.read(key: "FB_TOKEN");
      // print(fbToken);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: credentials['email'], password: credentials['password']);
      // print('=====> USER CREDENTIALS $userCredential');
      credentials.putIfAbsent('device_token', () => fbToken);
      credentials.remove('password');
      SecureStorage.instance.write(key: "USER_UID", value: userCredential.user.uid);
      dynamic response = await ApiService.instance.updateAdmin('admins', credentials);
      SecureStorage.instance.write(key: "USER_ID", value: response['id']);
      callback();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      // print(response);
    }catch(e){
      if(e is FirebaseAuthException){
        loginError.value = 'Email and/or password is incorrect';
      }
      // print('INVALID STILL ${e.runtimeType}');
    }finally{
      isSubmitting.value = false;
    }

  }

  void onSubmitLogin(BuildContext context, String contact) async{
    print('CONTACT NUMEBR IS $contact');
    buildContext = context;
    // print('FROM controller ${fullNameController.text}');
    // onChangedFullNameTextField(fullNameController.text);
    // onChangedContactNumberTextField(contactNumberController.text);

    if(/*fullNameFieldError.value.isEmpty && contactNumberFieldError.value.isEmpty*/ contact.isNotEmpty){
      Get.find<DashboardController>().contactNo = contact;
      isSubmitting.value = true;
      await auth.verifyPhoneNumber(
        phoneNumber: '$phoneNumberCountryCode$contact',
        verificationCompleted:  (context) => verificationCompleted, //(PhoneAuthCredential credential) {},
        verificationFailed: verificationFailed, //(FirebaseAuthException e) {},
        codeSent: verificationCodeSent, //(String verificationId, int resendToken) {},
        codeAutoRetrievalTimeout: verificationCodeAutoRetrievalTimeout, //(String verificationId) {},
        timeout: const Duration(seconds: 120)
      );
      // print('Veruifical method clalled');
    }
  }

  void verificationCompleted(BuildContext context, PhoneAuthCredential credential) async{
    UserCredential userCredential = await auth.signInWithCredential(credential);
    User authUser = userCredential.user;
    if(authUser != null){
      String fbToken = await SecureStorage.instance.read(key: "FB_TOKEN");
      // print(fbToken);
      print(authUser);
      dynamic response = await ApiService.instance.createUser('users', {
        'name': 'User', 'contact': authUser.phoneNumber, 'uid': authUser.uid, 'device_token' : fbToken});
      // print(response);
      SecureStorage.instance.write(key: "USER_ID", value: response['id']);

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
    // print('SIGNED IN SUCCESS automatically');
  }

  void verificationFailed(FirebaseAuthException e) {
    // print('AN ERROR OCCURED $e');
  }

  void verificationCodeSent(String verificationId, int resendToken) async{
    // print('Verification ID $verificationId');
    // print('resend token $resendToken');
    _manualCodeEnter.value = true;
    _verificationId =  verificationId;
    Navigator.of(buildContext).pushReplacement(MaterialPageRoute(builder: (context) => Token(submitCallback: onTokenVerificationSubmit,)));
  }

  void verificationCodeAutoRetrievalTimeout(String verificationId) {
    print('Retrieeval code $verificationId');
  }

  // void signInWithPhoneNumber(String verificationId, String smsCode)async{
  //   try{
  //     final AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //     final User user = (await auth.signInWithCredential(credential)).user;
  //     print('COOl, finally logged iN');
  //   }catch(e){
  //     print('Error Logging in User and error is $e');
  //   }
  // }

  void onTokenVerificationSubmit(BuildContext context)async {
    // print('manual verification happens here!');
    final PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: '123456');
    verificationCompleted(context, phoneAuthCredential);
    // final UserCredential userCredential = await auth.signInWithCredential(credential);

  }
}