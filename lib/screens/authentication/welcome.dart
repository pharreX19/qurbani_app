import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/authentication/admin/login.dart' as admin;
import 'package:qurbani/screens/authentication/user/login.dart' as user;
import 'package:qurbani/screens/authentication/login_button.dart';
import 'package:qurbani/screens/home.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class Welcome extends StatelessWidget {

  void _loginWithPhoneNumber(context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => user.Login()));
  }

  void _continueAsGuest(context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Column(
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
    );
  }
}
