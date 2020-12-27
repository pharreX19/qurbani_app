import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/dashboard/user/dashboard.dart';
import 'package:qurbani/screens/request/request_form.dart';

class NameDetailsBottomSheet extends StatelessWidget {
  final Map<String, dynamic> name;
  final String meaning;

  NameDetailsBottomSheet({this.name, this.meaning});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeHorizontal * 5,
          left: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5
      ),
      height: SizeConfig.blockSizeVertical * 27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name['name_en']),
          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
          Text(name['name_ar']),
          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
          Text(name['name_dh']),
          SizedBox(height: SizeConfig.blockSizeVertical * 2.5,),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(meaning)),
          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              Get.find<DashboardController>().setChildName(name['meaning']);
              Get.find<DashboardController>().onServiceTypeSelectedCallback(context, 'Aqeeqah');
            },
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Continue with Aqeeqah', style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                  Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.blockSizeHorizontal * 4,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
