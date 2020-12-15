import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/authentication/login.dart';
import 'package:qurbani/screens/dashboard/dashboard.dart';
import 'package:qurbani/screens/requests/requests.dart';
import 'package:qurbani/screens/settings/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _screens = [
    Dashboard(),
    Requests(),
    Settings()
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
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onCurrentIndexChanged,
        items: [
          BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard_customize)),
          BottomNavigationBarItem(label: 'Requests', icon: Icon(Icons.playlist_add_check_sharp)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
