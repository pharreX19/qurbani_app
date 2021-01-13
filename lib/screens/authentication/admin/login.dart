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

  void _submitLogin(){
    FocusScope.of(context).unfocus();
    Get.find<LoginController>().onSubmitAdminLogin(context,
        {
          'name': _validationService.name.value,
          'email': _validationService.email.value,
          'password' : _validationService.password.value,
          'contact' : _validationService.contact.value
        }, _validationService.resetValues);
    // data.onSubmitLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    _validationService = Provider.of<LoginValidationProvider>(context);
    // LoginController _controller =  Get.put(LoginController());
    return GetX<LoginController>(
      init: LoginController(),
      builder: (controller){
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
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
                              top: SizeConfig.blockSizeVertical * 15,
                              bottom: SizeConfig.blockSizeVertical* 1.5
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Text('Sign in')),
                              // Text('Login'),
                            ],
                          ),
                        ),
                        LoginTextField(
                          controller: _validationService.emailController, //data.fullNameController,
                          title: 'Email',
                          icon: Icons.perm_identity,
                          errorText: _validationService.email.error, //data.fullNameFieldError.value == '' ? null : data.fullNameFieldError.value,
                          onChanged: (String email){
                            _validationService.onEmailChanged(email);
                          }, //data.onChangedFullNameTextField,
                          maxLength: 100,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        LoginTextField(
                          obscureText: true,
                          controller: _validationService.passwordController, //data.fullNameController,
                          title: 'Password',
                          icon: Icons.lock_open_rounded,
                          errorText: _validationService.password.error, //data.fullNameFieldError.value == '' ? null : data.fullNameFieldError.value,
                          onChanged: (String password){
                            _validationService.onPasswordChanged(password);
                          }, //data.onChangedFullNameTextField,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        LoginTextField(
                          controller: _validationService.contactController, //data.contactNumberController,
                          title: 'Contact Number',
                          icon: Icons.phone_in_talk,
                          errorText: _validationService.contact.error, //data.contactNumberFieldError.value == '' ? null : data.contactNumberFieldError.value,
                          onChanged: (String contact){
                            _validationService.onContactChanged(contact);
                          }, //data.onChangedContactNumberTextField,
                          maxLength: 20,
                          keyboardType: TextInputType.number,
                        ),
                        Obx((){
                          if(controller.loginError.value != null || controller.loginError.value.isNotEmpty){
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2),
                                child: Text(controller.loginError.value, style: TextStyle(color: Colors.red),),
                              ),
                            );
                          }
                          return Container();
                        }),
                        InkWell(
                          onTap: _validationService.isValid ? _submitLogin : null,
                          child: Container(
                              height: SizeConfig.blockSizeVertical * 7,
                              decoration: BoxDecoration(
                                  color: _validationService.isValid ?  Colors.teal : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.lock_open_outlined, color: _validationService.isValid ? Colors.white : Colors.grey[500],),
                                  SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                                  Text('Continue', style: TextStyle(color: _validationService.isValid ? Colors.white : Colors.grey[500]),),
                                ],
                              )
                          ),
                        ),
                        // Spacer(),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(
                        //             builder: (context) => Home()));
                        //   },
                        //   child: Padding(
                        //     padding: EdgeInsets.all(
                        //         SizeConfig.blockSizeHorizontal * 2),
                        //     child: Align(
                        //         alignment: Alignment.bottomCenter,
                        //         child: Text(
                        //           'Continue as Guest',
                        //           style: TextStyle(fontStyle: FontStyle.italic),
                        //         )),
                        //   ),
                        // )
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
                          Text('Please wait...', style: TextStyle(color: Colors.white),)
                        ],
                      )),
                  color: Colors.black.withOpacity(0.8),
                ) : Container(),
              ],
            )
        );
      },
    );
          // },
        // )
  // );
  }
}
