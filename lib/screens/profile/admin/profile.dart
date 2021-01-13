import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/profile_controller.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            body: MainLayout(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profile'),
                    FutureBuilder(
                      future: Get.find<ProfileController>().profile('admins'),
                      builder: (context, AsyncSnapshot snapshot){
                        if(snapshot.hasError){
                          return Expanded(
                            child: Center(
                              child: Text('An error occurred, please try again later'),
                            ),
                          );
                        }
                        if(snapshot.hasData){
                          dynamic user = snapshot.data.data();
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Column(
                                children: [
                                  ListTile(title: Text(user['name']), leading: Icon(Icons.person),),
                                  ListTile(title: Text(user['email']),leading: Icon(Icons.alternate_email),),
                                  ListTile(title: Text(user['contact']), leading: Icon(Icons.call_rounded),),
                                  SubmitButton(
                                      title: 'Logout',icon: Icons.logout,
                                      submitCallback: (){
                                        Get.find<ProfileController>().logout(context, 'admins');
                                      }
                                  )
                                ],
                              )
                            ],
                          );
                        }
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    )
                  ],
                )
            ),
          ),
        ),
        Obx((){
          return Get.find<ProfileController>().isSubmitting.value ? Container(
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
          ) : Container();
        })
      ],
    );
  }
}
