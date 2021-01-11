import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/controllers/homeController.dart';
import 'package:qurbani/controllers/requests_controller.dart';
import 'package:qurbani/screens/calendar/calendar_view.dart';
import 'package:qurbani/screens/dashboard/admin/monthly_sales_chart.dart';
import 'package:qurbani/screens/dashboard/admin/weekly_sales_chart.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/dashboard/user/service_type_bottomsheet.dart';
import 'package:qurbani/screens/names/names.dart';
import 'package:qurbani/screens/notifications.dart';
import 'package:qurbani/screens/request/request_form.dart';
import 'package:qurbani/screens/requests/admin/request_detail.dart';
import 'package:qurbani/screens/requests/admin/requests.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/dashboard/main_card.dart';

class Dashboard extends StatefulWidget {
  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ScrollController _scrollController = ScrollController();
  // List<Map<String, dynamic>> _serviceStatus = [
  //   { 'title' : 'Pending', 'count': 10 },
  //   { 'title' : 'Approved', 'count': 5 },
  //   { 'title' : 'Completed', 'count': 3 },
  //   ];

  Widget _buildHeader(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Hello, Admin!'),
            Spacer(),
            IconButton(icon: Icon(Icons.today), onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarView()));
            },),
            IconButton(icon: Icon(Icons.notifications_active_outlined), onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notifications()));
            },),
          ],
        ),
        Text('${DateTime.now().toLocal()}'),
      ],
    );
  }

  Widget _buildEarnings(){
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 2),
      child: ListTile(
        title: Obx((){
          return Text(Get.find<DashboardController>().currentMonthEarning.toStringAsFixed(2));
        }),
        subtitle: Text('This months Earning'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('2.5%'),
            Icon(Icons.show_chart)
          ],
        ),
      ),
    );
  }

  Widget _buildServiceStatByStatus(){
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
      child: Obx((){
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: Get.find<DashboardController>().requestStats.map((element){
               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       Icon(Icons.addchart_rounded),
                       Text(element['count'].toString())
                     ],
                   ),
                   Text(element['title'])
                 ],
               );
             }).toList()
        );
      })
    );
  }

  Widget _buildStatCharts(){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
        child: Center(
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 85,
            child: Obx((){
              if(Get.find<DashboardController>().dailyRequestsStat.length > 0){
                return WeeklySalesChart(dailyRequests: Get.find<DashboardController>().dailyRequestsStat,);
              }
              return Center(child: CircularProgressIndicator());
            }) ),
        ),
      ),
    );
  }

  Widget _buildUpcomingRequests(){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
              child: Text('Upcoming requests'),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1,),
            Obx((){
              if(Get.find<DashboardController>().requests.length > 0){
                return Expanded(
                    child: ListView.builder(
                      itemCount: Get.find<DashboardController>().requests.length,
                      itemBuilder: (context, int index){
                        dynamic requests = Get.find<DashboardController>().requests;
                        if(DateTime.fromMillisecondsSinceEpoch(requests[index]['date']['_seconds'] * 1000).isAfter(DateTime.now()) &&
                            (requests[index]['status'].toString().toLowerCase() == 'pending' || requests[index]['status'].toString().toLowerCase() == 'approved')){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail(document: requests[index],)));
                              },
                              tileColor: Colors.grey[200],
                              contentPadding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 10),
                              title: Text(requests[index]['service']['name']),
                              subtitle: Text(requests[index]['service']['type']),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('QTY: ${requests[index]['quantity']}'),
                                  Text(DateTime.fromMillisecondsSinceEpoch(requests[index]['date']['_seconds'] * 1000).toLocal().toString())
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ));
              }
              return Expanded(child: Center(child: Text('No Requests found')));
            })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    Get.find<DashboardController>().initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: MainLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildEarnings(),
              _buildServiceStatByStatus(),
              _buildStatCharts(),
              _buildUpcomingRequests()
            ],
          ),
        ),
      ),
    );
  }
}
