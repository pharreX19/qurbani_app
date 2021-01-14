import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/home_controller.dart';
import 'package:qurbani/screens/authentication/admin/login.dart' as admin;
import 'package:qurbani/screens/authentication/user/login.dart' as user;
import 'package:qurbani/screens/authentication/login_button.dart';
import 'package:qurbani/screens/authentication/user/token.dart';
import 'package:qurbani/screens/home.dart';
import 'package:qurbani/services/secure_storage.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class Welcome extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());


  void _loginWithPhoneNumber(context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Token())); //user.Login()));
  }

  void _continueAsGuest(context){
    SecureStorage.instance.deleteAll();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeVertical * 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset('assets/images/logo.png', height: SizeConfig.blockSizeHorizontal * 15,),
            SizedBox(height: SizeConfig.blockSizeVertical * 3,),
            Text('Welcome to Qurbai'),
            Spacer(),
            LoginButton(icon: Icons.call, title: 'Login with phone number', callback: (){
              _loginWithPhoneNumber(context);
            },),
            LoginButton(title: 'Continue as Guest', backgroundColor: Colors.white, callback: (){
              _continueAsGuest(context);
            },),
            // InkWell(
            //
                Padding(
                  padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2, top: SizeConfig.blockSizeVertical * 1),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => admin.Login()));
                    },
                    child: Text('Admin Login', style: TextStyle(color: Colors.teal, fontStyle: FontStyle.italic),),
                  )
                )
              // },
            // )
          ],
        ),
      ),
    );
  }
}
