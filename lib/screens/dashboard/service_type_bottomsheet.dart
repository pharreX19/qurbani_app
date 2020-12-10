import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';

class ServiceTypeBottomSheet extends StatelessWidget {
  final Function callback;
  ServiceTypeBottomSheet({this.callback});

  final List<Map<String, dynamic>> _serviceName = [
    {'title': 'Sadaqah', 'icon': Icons.workspaces_outline},
    {'title': 'Udhiya', 'icon': Icons.map},
    {'title': 'Aqeeqah', 'icon': Icons.style},
    {'title': 'Others', 'icon': Icons.palette_outlined},
  ];

  void _serviceTypeSelected(BuildContext context, String serviceType){
//    callback(selectedServiceName);
    Navigator.pop(context);
    Get.find<DashboardController>().setRequestedServiceType(serviceType);
    callback();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 35,
      child: ListView.builder(
        itemCount: _serviceName.length,
        itemBuilder: (context, int index) {
          return ListTile(
            leading: Icon(_serviceName[index]['icon']),
            title: Text(_serviceName[index]['title']),
            onTap: (){
              _serviceTypeSelected(context,  _serviceName[index]['title']);
            },
          );
        },
      ),
    );
  }
}
