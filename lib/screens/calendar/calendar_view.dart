import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/calendar_controller.dart';
import 'package:qurbani/controllers/questions_and_names_controller.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MainLayout(
            child: GetX<CalendarController>(
          init: CalendarController(),
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Service Calendar'),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  CalendarBottomSheet(
                    onDateSelectedCallback: controller.setTodaysRequests,
                  ),
//                  SizedBox(
//                    height: SizeConfig.blockSizeVertical * 1,
//                  ),
                  Expanded(
                    child: controller.todaysRequests.length == 0 ? Center(child: Text('No requests for today'),) :
                    ListView.builder(
                        itemCount: controller.todaysRequests.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
                            child: ListTile(
                                tileColor: Colors.teal[50],
                                title: Text(
                                    controller.todaysRequests[index]['type']),
                                subtitle: Text(
                                    controller.todaysRequests[index]['name']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        controller.todaysRequests[index]['child_name'] ?? ''),
                                    SizedBox(width: SizeConfig.blockSizeHorizontal * 10,),
                                    Text(
                                        controller.todaysRequests[index]['quantity'].toString()),
                                  ],
                                )
                            ),
                          );
                        }),
                  )
                ]);
          },
        )),
      ),
    );
  }
}
