import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/dashboard/user/dashboard.dart';
import 'package:qurbani/screens/request/request_form.dart';

class NameDetailsBottomSheet extends StatelessWidget {
  final String name;
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
      height: SizeConfig.blockSizeVertical * 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name),
          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
          Text('Name in arabic'),
          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
          Text('Name in dhivehi'),
          SizedBox(height: SizeConfig.blockSizeVertical * 2.5,),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(meaning)),
          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              Get.find<DashboardController>().setChildName(name);
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
