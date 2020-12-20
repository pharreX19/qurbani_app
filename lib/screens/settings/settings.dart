import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/service_settings_controller.dart';
import 'package:qurbani/screens/name_list_settings/name_settings.dart';
import 'package:qurbani/screens/questions_settings/questions_settings.dart';
import 'package:qurbani/screens/service_settings/service_settings.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Settings extends StatefulWidget {
  final ServiceSettingsController _serviceSettingsController = Get.put(ServiceSettingsController());

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<Map<String, dynamic>> _services = [
    {'name' : 'Udhiya', 'price': 700, 'isActive' : true},
    {'name' : 'Aqeeqah', 'price': 1000, 'isActive' : true },
    {'name' : 'Sadaqat', 'price': 1500,'isActive' : true },
    {'name' : 'Others', 'price': 1700, 'isActive' : true}
  ];

  bool _isAdmin = true;

  Widget _buildCategory(BuildContext context, String name, Widget detailPage){
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//          Padding(
//            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, bottom: SizeConfig.blockSizeVertical * 0.8),
//            child: Text(title),
//          ),
          ListTile(
            tileColor: Colors.grey[100],
            title: Text(name),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.blockSizeHorizontal * 5,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => detailPage));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MainLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Settings'),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                ListTile(
                  title: Text('Admin Privileges'),
                  trailing: Switch(
                    value: _isAdmin,
                    activeColor: Colors.teal,
                    onChanged: (value){
                      setState(() {
                        _isAdmin = value;
                      });
                    },
                  ),
                ),
//                Padding(
//                  padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, bottom: SizeConfig.blockSizeVertical * 0.8),
//                  child: Text('Services'),
//                ),
              !_isAdmin ? Expanded(
                child: Center(
                  child: Text('You are acting as a User, Please turn on Admin Privileges'),
                ),
              ) :
                  Column(
                    children: [
                      ..._services.map((service){
                        return ListTile(
                          tileColor: Colors.grey[100],
                          title: Text(service['name']),
                          trailing: Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.blockSizeHorizontal * 5,),
                          onTap: (){
                            Get.find<ServiceSettingsController>().setServiceType(service['name']);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ServiceSettings(title: service['name'],)));
                          },
                        );
                      }),
                      _buildCategory(context, 'Name List', NameSettings()),
                      _buildCategory(context, 'Questions', QuestionsSettings())
                    ],
                  ),
              ])
        ),
      ),
    );
  }
}
