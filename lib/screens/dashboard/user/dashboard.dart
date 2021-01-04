import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/dashboard/user/service_type_bottomsheet.dart';
import 'package:qurbani/screens/information/information.dart';
import 'package:qurbani/screens/names/names.dart';
import 'package:qurbani/screens/request/request_form.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/dashboard/main_card.dart';

class Dashboard extends StatefulWidget {
  final List<Map<String, dynamic>> _mainCardContent = [
    {'title': 'Information', 'path': 'assets/images/information.jpg', 'detail-page' : Information(tag: 'Information', imagePath: 'assets/images/information.jpg',)},
    {'title': 'Names', 'path': 'assets/images/names.jpg' , 'detail-page' : Names(tag: 'Names', imagePath: 'assets/images/names.jpg',)},
    {'title': 'FAQ', 'path': 'assets/images/information.jpg', 'detail-page' : Names(tag: 'FAQ', imagePath: 'assets/images/names.jpg',)},
  ];

  final List<Map<String, dynamic>> _serviceTypes = [
    {'name' : 'Goat',  'icon' : Icons.waterfall_chart },
    {'name' : 'Sheep', 'icon' : Icons.anchor_sharp },
    {'name' : 'Cow', 'icon' : Icons.anchor_sharp },
    {'name' : 'Camel', 'icon' : Icons.adjust_sharp }
  ];

  final List<Map<String, dynamic>> _services = [
    {'name': 'Sadaqah', 'icon': Icons.workspaces_outline},
    {'name': 'Udhiya', 'icon': Icons.map},
    {'name': 'Aqeeqah', 'icon': Icons.style},
    {'name': 'Others', 'icon': Icons.palette_outlined},
  ];


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
//  int _month = DateTime.now().month;
//  int _year = DateTime.now().year;
//  String _requestedService;
//  DateTime _requestServiceDate;
//
//  void _onDateSelectedCallback(){
////    _requestServiceDate = DateTime(_year, _month, date);
//    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestForm()));//(requestedServiceDate: _requestServiceDate, requestedService: _requestedService)));
////    showModalBottomSheet(shape: RoundedRectangleBorder(
////      borderRadius: BorderRadius.vertical(
////        top: Radius.circular(8.0),
////      ),
////    ), context: context, builder: (context){
////      return RequestForm(requestedServiceDate: _requestServiceDate, requestedService: _requestedService,);
////    });
//  }
//
//  void _onServiceTypeSelectedCallback(){
////    _requestedService = serviceType;
//    showModalBottomSheet(shape: RoundedRectangleBorder(
//      borderRadius: BorderRadius.vertical(
//        top: Radius.circular(8.0),
//      ),
//    ), context: context, builder: (context){
//      return CalendarBottomSheet(onDateSelectedCallback: _onDateSelectedCallback,);
//    });
//  }

//@override
//  void initState() {
//    super.initState();
//  }

  List<Map<String, dynamic>> generateServices(String serviceType){
    if(serviceType.toLowerCase() != 'goat'){
      return widget._services.where((element) => element['name'].toString().toLowerCase() != 'aqeeqah').toList();
    }
    return widget._services;
  }

  void _onServiceTapped(BuildContext context, String serviceType){
//    widget.dashboardController.childName = null;
    Get.find<DashboardController>().serviceType = serviceType;
    showModalBottomSheet(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8.0),
      ),
    ), context: context, builder: (context){
      return ServiceTypeBottomSheet(generateServices(serviceType));
    });
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ServiceRequetForm()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: MainLayout(
          child: Column(
            children: [
              Row(
                children: [
                  Text('Hello, Guest!'),
                  Spacer(),
                  Icon(Icons.notifications_active_outlined)
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
              Expanded(
                child: Column(
                  children: [
                    ...widget._mainCardContent.map((element) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: SizeConfig.blockSizeHorizontal * 2),
                        child: MainCard(title: element['title'], imagePath: element['path'], detailsPage: element['detail-page'],),
                      ),
                    )),
                    // SizedBox(height: SizeConfig.blockSizeVertical * 2,),
//                    Align(
//                        alignment: Alignment.centerLeft,
//                        child: Padding(
//                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
//                          child: Text('QURBANI SERVICES'),
//                        )),
                  ],
                ),
              ),
//              SizedBox(height: SizeConfig.blockSizeVertical * 1,),
              FutureBuilder(
                future: Get.find<DashboardController>().fetchAllServices(),
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text('An error occurred, please try again'),
                    );
                  }
                  if(snapshot.hasData){
                    return Wrap(
                        alignment: WrapAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: widget._serviceTypes.map((element){
                          return GestureDetector(
                            onTap: (){
                              _onServiceTapped(context, element['name']);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeHorizontal * 3,
                                  horizontal: SizeConfig.blockSizeHorizontal * 6
                              ),
                              child: Column(
                                children: [
                                  Icon(element['icon']),
                                  SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                                  // Text(element['title']),
                                  // SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                                  Text(element['name']),
                                ],
                              ),
                            ),
                          );
                        }).toList()
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
