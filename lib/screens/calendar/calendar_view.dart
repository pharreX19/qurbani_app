import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/calendar_controller.dart';
import 'package:qurbani/controllers/questions_and_names_controller.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/requests/admin/requests.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class CalendarView extends StatelessWidget {
  final CalendarController _calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MainLayout(
            child: Column(
              mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Service Calendar'),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Obx((){
                    return Card(
                      child: CalendarBottomSheet(
                        onDateSelectedCallback: Get.find<CalendarController>().setTodaysRequests,
                        calendarPinPoints: Get.find<CalendarController>().populateRequestDates(),
                      ),
                    );
                  }),
                 SizedBox(
                   height: SizeConfig.blockSizeVertical * 5,
                 ),
                  Obx((){
                    // print(Get.find<CalendarController>().requestDates.length);
                    // print(Get.find<CalendarController>().populateRequestDates());
                    // print(Get.find<CalendarController>().selectedDate.value);
                    // if(Get.find<CalendarController>().populateRequestDates().contains('2020-12-12')) {
                    String selectedDate = Get.find<CalendarController>().selectedDate.value;
                    return Expanded(
                        child: ListView.builder(
                            itemCount: Get.find<CalendarController>().todaysRequests.length,
                            itemBuilder: (context, int index) {
                              print('===> CALENDAR ${Get.find<CalendarController>().todaysRequests[index]}');
                              String date = (DateTime.fromMillisecondsSinceEpoch(
                                  Get.find<CalendarController>().todaysRequests[index]['date']['_seconds'] *
                                      1000)).toString().substring(0, 10);
                              if (date != selectedDate) {
                                return Container();
                              }
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.blockSizeVertical * 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border(
                                      left: BorderSide(
                                        color: Get.find<CalendarController>().todaysRequests[index]['status'].toString().toLowerCase() == 'pending' ?  Colors.orange :
                                        Get.find<CalendarController>().todaysRequests[index]['status'].toString().toLowerCase() == 'approved' ? Colors.blue :
                                        Get.find<CalendarController>().todaysRequests[index]['status'].toString().toLowerCase() == 'completed' ? Colors.green :
                                        Colors.red, width: 4.5),)
                                  ),
                                  child: ListTile(
                                      // tileColor: Colors.teal[50],
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Requests()));
                                      },
                                      title: Text(
                                          Get.find<CalendarController>().todaysRequests[index]['service']['name']),
                                      subtitle: Text(
                                          Get.find<CalendarController>().todaysRequests[index]['service']['type']),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Get.find<CalendarController>().todaysRequests[index]['name'] == null ? Container() :
                                          Text(Get.find<CalendarController>().todaysRequests[index]['name']),
                                          SizedBox(width: SizeConfig.blockSizeHorizontal * 10,),
                                          Text('QTY  ${Get.find<CalendarController>().todaysRequests[index]['quantity']}'),
                                        ],
                                      )
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                    // return Center(
                    //   child: Text('No Requests found for today'),
                    )
                  // })
                ],
            )
        )),
      );
  }
}
