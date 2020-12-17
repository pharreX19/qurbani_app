import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/screens/dashboard/admin/monthly_sales_chart.dart';
import 'package:qurbani/screens/dashboard/admin/weekly_sales_chart.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/dashboard/user/service_type_bottomsheet.dart';
import 'package:qurbani/screens/names/names.dart';
import 'package:qurbani/screens/request/request_form.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/dashboard/main_card.dart';

class Dashboard extends StatefulWidget {
  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _serviceStatus = [
    { 'title' : 'Pending', 'count': 10 },
    { 'title' : 'Approved', 'count': 5 },
    { 'title' : 'Completed', 'count': 3 },
    ];

  Widget _buildHeader(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Hello, Admin!'),
            Spacer(),
            IconButton(icon: Icon(Icons.today)),
            IconButton(icon: Icon(Icons.notifications_active_outlined)),
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
        title: Text('MVR 2500'),
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
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _serviceStatus.map((element){
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
      ),
    );
  }

  Widget _buildStatCharts(){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                height: SizeConfig.blockSizeVertical * 30,
                child: WeeklySalesChart()),
            // SizedBox(height: SizeConfig.blockSizeVertical * 1,),
            Container(
                padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2
                ),
                height: SizeConfig.blockSizeVertical * 30,
                child: MonthlySalesChart()),
            Container(
              height: SizeConfig.blockSizeVertical * 19,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingRequests(){
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      maxChildSize: 0.6,
      minChildSize: 0.2,
      builder: (context, _scrollController){
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                offset: Offset(0, -1),
                blurRadius: 4.0,
                spreadRadius: 1.0
              )
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0)
            )
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2),
                  width: SizeConfig.blockSizeHorizontal * 10,
                  height: SizeConfig.blockSizeVertical * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1),
                child: Text('Upcoming Requests'),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: 10,
                  itemBuilder: (context, int index){
                    return ListTile(
                      leading: Icon(Icons.bubble_chart),
                      title: Text('Index $index'),
                      subtitle: Text('13 December 2020'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: (){
                        print('Details Page');
                      },
                    );
                  },
                ),
              )
            ],
          )
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            MainLayout(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildEarnings(),
                  _buildServiceStatByStatus(),
                  _buildStatCharts(),
                ],
              ),
            ),
            _buildUpcomingRequests()
          ],
        ),
      ),
    );
  }
}
