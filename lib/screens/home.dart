import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
// import 'package:qurbani/controllers/homeController.dart';
import 'package:qurbani/controllers/home_controller.dart';
import 'package:qurbani/screens/authentication/user/login.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


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
  void initState() {
    super.initState();
    Get.find<HomeController>().setNavigationItems();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller){
        if(controller.items.length > 0){
          return Scaffold(
            body: Obx((){
              return controller.screens[Get.find<HomeController>().currentIndex.value];
            }),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              selectedItemColor: Colors.teal,
              unselectedItemColor: Colors.grey,
              onTap: Get.find<HomeController>().setCurrentIndex,
              items: controller.items,
            ),
          );
        }
        return Center(
          child: Text('PLease wait'),
        );
      },
    );
  }
}
