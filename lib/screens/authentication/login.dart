import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/dashboard/dashboard.dart';
import 'package:qurbani/screens/home.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 8
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 2,
              horizontal: SizeConfig.blockSizeVertical * 6
          ),
          child: Column(
            children: [
              Center(
                  child: Image.asset('assets/images/logo.png',
                    width: SizeConfig.blockSizeHorizontal * 15,)),
              SizedBox(height: SizeConfig.blockSizeVertical * 8,),
              Text('Proceed with your'),
              Text('Login'),

              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  labelText: 'Full Name',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Icon(Icons.perm_identity),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
              TextField(
                decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    labelText: 'Contact Number',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.phone_in_talk),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
              Container(
                height: SizeConfig.blockSizeVertical * 6.5,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(50.0)
                ),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_open_outlined),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                    Text('Login'),
                  ],
                )),
              ),
              Spacer(),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                },
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text('Continue as Guest', style: TextStyle(fontStyle: FontStyle.italic),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
