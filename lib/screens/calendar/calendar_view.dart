import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/calendar_controller.dart';
import 'package:qurbani/controllers/feedback_controller.dart';
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
                  StreamBuilder(
                    stream: Get.find<CalendarController>().requests,
                    builder: (context, AsyncSnapshot snapshot){
                      if(snapshot.hasError){
                        return Expanded(
                          child: Center(
                            child: Text('An error occurred, please try again later'),
                          ),
                        );
                      }
                      if(snapshot.hasData){
                        List<DocumentSnapshot> requests = snapshot.data.documents;
                        return Expanded(
                          child: Column(
                            children: [
                              Card(
                                  child: CalendarBottomSheet(
                                    onDateSelectedCallback: Get.find<CalendarController>().setTodaysRequests,
                                    calendarPinPoints: Get.find<CalendarController>().populateRequestDates(requests),
                                  ),
                                ),
                              // }),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 5,
                              ),
                              Obx((){
                                String selectedDate = Get.find<CalendarController>().selectedDate.value;
                                return Expanded(
                                  child: ListView.builder(
                                      itemCount: requests.length, //Get.find<CalendarController>().todaysRequests.length,
                                      itemBuilder: (context, int index) {
                                        String date = (DateTime.fromMillisecondsSinceEpoch(requests[index]['date'].seconds *
                                            // Get.find<CalendarController>().todaysRequests[index]['date']['_seconds'] *
                                                1000)).toString().substring(0, 10);
                                        if (date != selectedDate) {
                                          return Container();
                                        }
                                        print(requests[index].data());
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: SizeConfig.blockSizeVertical * 1),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                border: Border(
                                                  left: BorderSide(
                                                      color: requests[index]['status'].toString().toLowerCase() == 'pending' ?  Colors.orange :
                                                      requests[index]['status'].toString().toLowerCase() == 'approved' ? Colors.blue :
                                                      requests[index]['status'].toString().toLowerCase() == 'completed' ? Colors.green :
                                                      Colors.red, width: 4.5),)
                                            ),
                                            child: ListTile(
                                              // tileColor: Colors.teal[50],
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Requests()));
                                                },
                                                title: Text(
                                                    requests[index]['service']['name']),
                                                subtitle: Text(
                                                    requests[index]['service']['type']),
                                                trailing: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    // requests[index]['name'] == null ? Container() :
                                                    // Text(requests[index]['name']),
                                                    SizedBox(width: SizeConfig.blockSizeHorizontal * 10,),
                                                    Text('QTY  ${requests[index]['quantity']}'),
                                                  ],
                                                )
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              })
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                  // })
                ],
            )
        )),
      );
  }
}
