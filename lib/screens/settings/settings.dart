import 'package:cloud_firestore/cloud_firestore.dart';
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
  static const List<String> SERVICES = ['Sadaqah', 'Aqeeqah', 'Others', 'Udhiya'];
  bool _isAdmin = true;

  Widget _buildCategory(BuildContext context, String name, Widget detailPage){
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                StreamBuilder(
                  stream: Get.find<ServiceSettingsController>().services,
                  builder: (context, AsyncSnapshot snapshot){
                    if(snapshot.hasError){
                      return Expanded(
                        child: Center(
                          child: Text('An error occurred, please try again later'),
                        ),
                      );
                    }
                    if(snapshot.hasData && _isAdmin){
                      List<DocumentSnapshot> serviceList = snapshot.data.documents;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                          Column(
                            children: [
                              ...serviceList.map((service){
                                return ListTile(
                                  tileColor: Colors.grey[100],
                                  title: Text(SERVICES[serviceList.indexOf(service)]),
                                  trailing: Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.blockSizeHorizontal * 5,),
                                  onTap: (){
                                    // Get.find<ServiceSettingsController>().fetchAllServiceType(service);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ServiceSettings(
                                      service: service,
                                      serviceName: SERVICES[serviceList.indexOf(service)].toLowerCase(),
                                    )));
                                  },
                                );
                              }),
                              _buildCategory(context, 'Name List', NameSettings()),
                              _buildCategory(context, 'Questions', QuestionsSettings())
                            ],
                          )
                        ],
                      );
                    }
                    if(snapshot.hasData && !_isAdmin){
                      return Expanded(
                        child: Center(
                          child: Text('You are acting as a User, Please turn on Admin Privileges'),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            )
        ),
      ),
    );
  }
}
