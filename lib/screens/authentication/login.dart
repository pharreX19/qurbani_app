import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/login_controller.dart';
import 'package:qurbani/screens/home.dart';
import 'package:qurbani/widgets/login/login_text_field.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetX<LoginController>(
          init: LoginController(),
          builder: (data) {
            return Stack(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeVertical * 6),
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
                              bottom: SizeConfig.blockSizeVertical* 3
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Proceed with your'),
                              Text('Login'),
                            ],
                          ),
                        ),
                        LoginTextField(
                          controller: data.fullNameController,
                          title: 'Full Name',
                          icon: Icons.perm_identity,
                          errorText: data.fullNameFieldError.value == '' ? null : data.fullNameFieldError.value,
                          onChanged: data.onChangedFullNameTextField,
                          maxLength: 100,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        LoginTextField(
                          controller: data.contactNumberController,
                          title: 'Contact Number',
                          icon: Icons.phone_in_talk,
                          errorText: data.contactNumberFieldError.value == '' ? null : data.contactNumberFieldError.value,
                          onChanged: data.onChangedContactNumberTextField,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        InkWell(
                          onTap: (){
                            FocusScope.of(context).unfocus();
                            data.onSubmitLogin();
                          },
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 6.5,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.lock_open_outlined),
                                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                                      Text('Login'),
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
                data.isSubmitting.value ? Container(
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
