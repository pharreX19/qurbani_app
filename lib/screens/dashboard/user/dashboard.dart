import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/dashboard/user/service_type_bottomsheet.dart';
import 'package:qurbani/screens/names/names.dart';
import 'package:qurbani/screens/request/request_form.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/dashboard/main_card.dart';

class Dashboard extends StatefulWidget {
  final List<Map<String, dynamic>> _mainCardContent = [
    {'title': 'Information', 'path': 'assets/images/information.jpg', 'detail-page' : Names(tag: 'Information', imagePath: 'assets/images/information.jpg',)},
    {'title': 'Names', 'path': 'assets/images/names.jpg' , 'detail-page' : Names(tag: 'Names', imagePath: 'assets/images/names.jpg',)},
    {'title': 'FAQ', 'path': 'assets/images/information.jpg', 'detail-page' : Names(tag: 'FAQ', imagePath: 'assets/images/names.jpg',)},
  ];

  final List<Map<String, dynamic>> _serviceIcons = [
    {'title' : 'Goat', 'price': 'MVR 700', 'icon' : Icons.waterfall_chart },
    {'title' : 'Sheep', 'price': 'MVR 1000', 'icon' : Icons.anchor_sharp },
    {'title' : 'Cow', 'price': 'MVR 1500','icon' : Icons.anchor_sharp },
    {'title' : 'Camel', 'price': 'MVR 1700', 'icon' : Icons.adjust_sharp }
  ];

  final DashboardController dashboardController = Get.put(DashboardController());


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

@override
  void initState() {
    super.initState();
  }

  void _onServiceTapped(BuildContext context){
    widget.dashboardController.childName = null;
    showModalBottomSheet(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8.0),
      ),
    ), context: context, builder: (context){
      return ServiceTypeBottomSheet();
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
              Wrap(
                alignment: WrapAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: widget._serviceIcons.map((element){
                  return GestureDetector(
                    onTap: (){
                      _onServiceTapped(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                      child: Column(
                        children: [
                          Icon(element['icon']),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                          // Text(element['title']),
                          // SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                          Text(element['price']),
                        ],
                      ),
                    ),
                  );
                }).toList()
              )
            ],
          ),
        ),
      ),
    );
  }
}
