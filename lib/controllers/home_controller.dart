import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/screens/settings/settings.dart' as admin;
import 'package:qurbani/services/local_notification.dart';
import 'package:qurbani/services/push_message.dart';
import 'package:qurbani/services/secure_storage.dart';
import 'package:qurbani/screens/dashboard/admin/dashboard.dart' as admin;
import 'package:qurbani/screens/dashboard/user/dashboard.dart' as user;
import 'package:qurbani/screens/feedback/admin/feedback.dart' as admin;
import 'package:qurbani/screens/feedback/user/feedback.dart' as user;
import 'package:qurbani/screens/requests/admin/requests.dart' as admin;
import 'package:qurbani/screens/requests/user/requests.dart' as user;

class HomeController extends GetxController{
  final PushMessage _pushMessage = PushMessage();
  RxInt currentIndex = 0.obs;
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard_customize)),
    // BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard_customize)),
    BottomNavigationBarItem(label: 'Requests', icon: Icon(Icons.playlist_add_check_sharp)),
    // BottomNavigationBarItem(label: 'Requests', icon: Icon(Icons.playlist_add_check_sharp)),
    // BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
    // BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.feedback)),
    BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.feedback)),
  ];

  List<Widget> _adminScreens = [
    admin.Dashboard(),
    // user.Dashboard(),
    admin.Requests(),
    // user.Requests(),
    admin.Settings(),
    // user.Feedback(),
    admin.Feedback()
  ];

  List<Widget> _userScreens = [
    // admin.Dashboard(),
    user.Dashboard(),
    // admin.Requests(),
    user.Requests(),
    // admin.Settings(),
    user.Feedback(),
    // admin.Feedback()
  ];

  List<BottomNavigationBarItem> items = [];
  List<Widget> screens = [];

  @override
  void onInit() {
    print('INITIALIZING HOME CONTROLLER');
    super.onInit();
    _pushMessage.getToken().then((token) => setFirebaseTokenInLocalStorage(token));
    LocalNotification.instance.initialize();
  }

  void setNavigationItems(){
    SecureStorage.instance.read(key: "USER_UID").then((value){
      // print(FirebaseAuth.instance.pluginConstants.);
      if(value != null && value == FirebaseAuth.instance.currentUser.uid){
        _bottomNavigationBarItems.add(BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)));
        items.addAll(_bottomNavigationBarItems);
        setScreens('admin');
      }else{
        setScreens('user');
        items.addAll(_bottomNavigationBarItems);
      }
      update();
    });
  }

  void setScreens(String user){
    if(user.toLowerCase() == 'admin'){
      screens.addAll(_adminScreens);
    }else{
      screens.addAll(_userScreens);
    }
  }

  void setCurrentIndex(int index){
    currentIndex.value = index;
  }
  
  void setFirebaseTokenInLocalStorage(String token){
    print('SUE ROTKEN IS $token');
    SecureStorage.instance.write(key: "FB_TOKEN", value: token);
    // ApiService.instance.updateUser('users/k9JyOIaImGZodviv8n41', {'device_token' : token});
  }
}