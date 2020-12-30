import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/homeController.dart';
import 'package:qurbani/screens/authentication/login.dart';
import 'package:qurbani/screens/dashboard/admin/dashboard.dart' as admin;
import 'package:qurbani/screens/dashboard/user/dashboard.dart' as user;
import 'package:qurbani/screens/feedback/admin/feedback.dart' as admin;
import 'package:qurbani/screens/feedback/user/feedback.dart' as user;
import 'package:qurbani/screens/requests/admin/requests.dart' as admin;
import 'package:qurbani/screens/requests/user/requests.dart' as user;
import 'package:qurbani/screens/settings/settings.dart';

class Home extends StatefulWidget {
  final HomeController _homeController = Get.put(HomeController());
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _screens = [
    admin.Dashboard(),
    user.Dashboard(),
    admin.Requests(),
    user.Requests(),
    Settings(),
    user.Feedback(),
    admin.Feedback()

  ];

  int _currentIndex = 0;

  void _onCurrentIndexChanged(int index){
//    showDialog(context: context, builder: (context){
//      return AlertDialog(
//        insetPadding: EdgeInsets.all(10),
//        title: Text('Please login to continue'),
//        content: Login(),
//      );
//    });
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return _screens[Get.find<HomeController>().currentIndex.value];
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: Get.find<HomeController>().setCurrentIndex,
        items: [
          BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard_customize)),
          BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard_customize)),
          BottomNavigationBarItem(label: 'Requests', icon: Icon(Icons.playlist_add_check_sharp)),
          BottomNavigationBarItem(label: 'Requests', icon: Icon(Icons.playlist_add_check_sharp)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.feedback)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.feedback)),
        ],
      ),
    );
  }
}
