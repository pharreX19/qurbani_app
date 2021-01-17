import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/login_controller.dart';
import 'package:qurbani/providers/login_validation_provider.dart';
import 'package:qurbani/screens/home.dart';
import 'package:qurbani/widgets/login/login_text_field.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginValidationProvider _validationService;

  @override
  void initState() {
    super.initState();
    // _validationService.onNameChanged('User');
    // _validationService.onEmailChanged('user@user.com');
    // _validationService.onPasswordChanged('password');
  }

  void _submitLogin(){
    FocusScope.of(context).unfocus();
    Get.find<LoginController>().onSubmitLogin(context, _validationService.contact.value ?? Get.find<LoginController>().contactNumber.value);
    }

  @override
  Widget build(BuildContext context) {
    _validationService = Provider.of<LoginValidationProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetX<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return Stack(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeVertical * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset(
                          'assets/images/logo.png',
                          width: SizeConfig.blockSizeHorizontal * 15,
                        )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical* 10,
                              bottom: SizeConfig.blockSizeVertical* 1.5
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter your phone number'),
                              // Text('Login'),
                            ],
                          ),
                        ),
                        // LoginTextField(
                        //   controller: data.fullNameController,
                        //   title: 'Full Name',
                        //   icon: Icons.perm_identity,
                        //   errorText: data.fullNameFieldError.value == '' ? null : data.fullNameFieldError.value,
                        //   onChanged: data.onChangedFullNameTextField,
                        //   maxLength: 100,
                        //   keyboardType: TextInputType.name,
                        // ),
                        // SizedBox(
                        //   height: SizeConfig.blockSizeVertical * 2,
                        // ),
                        Stack(
                          children: [
                            LoginTextField(
                              prefix: Get.find<LoginController>().phoneNumberCountryCode.value,
                              controller: _validationService.contactController, //data.contactNumberController,
                              title: controller.contactNumber.value,
                              // hintText: controller.contactNumber.value,
                              icon: Icons.phone_in_talk,
                              errorText: _validationService.contact.error, //data.contactNumberFieldError.value == '' ? null : data.contactNumberFieldError.value,
                              onChanged: (String contact){
                                _validationService.onContactChanged(contact);
                              }, //data.onChangedContactNumberTextField,
                              maxLength: 20,
                              keyboardType: TextInputType.number,
                            ),
                            Positioned(
                                top: 21,
                                left: 48,
                                child: Text(Get.find<LoginController>().phoneNumberCountryCode.value))
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        InkWell(
                          onTap: _submitLogin, //_validationService.isValid ? _submitLogin : null,
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 4,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      // Icon(Icons.lock_open_outlined),
                                      // SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                                      Text('Continue'),
                                    ],
                                  )
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Continue as Guest',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                controller.isSubmitting.value ? Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 100,
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: SizeConfig.blockSizeVertical * 4,),
                          Text('Please wait...')
                        ],
                      )),
                  color: Colors.black.withOpacity(0.8),
                ) : Container(),
              ],
            );
          },
        ));
  }
}
