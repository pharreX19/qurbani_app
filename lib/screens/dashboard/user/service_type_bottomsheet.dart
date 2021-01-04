import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';

class ServiceTypeBottomSheet extends StatelessWidget {
//  final Function callback;
  final List<Map<String, dynamic>> services;

  ServiceTypeBottomSheet(this.services);

  // final List<Map<String, dynamic>> _serviceName = [
  //   {'title': 'Sadaqah', 'icon': Icons.workspaces_outline},
  //   {'title': 'Udhiya', 'icon': Icons.map},
  //   {'title': 'Aqeeqah', 'icon': Icons.style},
  //   {'title': 'Others', 'icon': Icons.palette_outlined},
  // ];

  void _serviceTypeSelected(BuildContext context, String service){
//    callback(selectedServiceName);
    Navigator.pop(context);
    Get.find<DashboardController>().onServiceTypeSelectedCallback(context, service);
//    callback();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
      height: SizeConfig.blockSizeVertical * 8 * services.length,
      child: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, int index) {
          return ListTile(
            leading: Icon(services[index]['icon']),
            title: Text(services[index]['name']),
            onTap: (){
              _serviceTypeSelected(context,  services[index]['name']);
            },
          );
        },
      ),
    );
  }
}
