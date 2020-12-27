import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';

class CalendarBottomSheet extends StatefulWidget {
  final Function onDateSelectedCallback;
  final List<dynamic> calendarPinPoints;
  CalendarBottomSheet({this.onDateSelectedCallback, this.calendarPinPoints});

  @override
  _CalendarBottomSheetState createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  final List<String> _days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<int> _daysCount = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  final List<String> _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  int _month;
  int _year;
  bool _nextMonthButtonEnabled = true;
  bool _previousMonthButtonEnabled = false;

  List<int> _generateDates({@required int month, @required int year}){
    List<int>dates = [];
    for(int i = 1; i <= _daysCount[month]; i++){
      dates.add(i);
    }
    _shiftMonthStartDay(dates, year, month);
    return dates;
  }

  int _getMonthStartDayIndex(int month, int year){
    return DateTime(year, month+1).weekday;
  }

  String _getMonthName(int month){
    return _months[month];
  }

  void _shiftMonthStartDay(List<int> dates, int year, int month){
    int monthStartDayIndex = _getMonthStartDayIndex(month, year);
    print(monthStartDayIndex);
    while(monthStartDayIndex > 0){
      dates.insert(0, 0);
      monthStartDayIndex--;
    }
  }

  void _onServiceDateSelected(int day){
    // setState(() {
    //   today = day;
    // });
    Get.find<DashboardController>().setRequestedServiceDate(day);
    widget.onDateSelectedCallback();
  }

  void _setNextMonth(){
    setState(() {
    if(_month == 11){
        _month = 0;
        _year = _year + 1;

    }else{
      _month = _month +1;
    }
    _nextMonthButtonEnabled = false;
    _previousMonthButtonEnabled = true;
    });
  }

  void _setPreviousMonth(){
    setState(() {
    if(_month == 0){
      _month = 11;
        _year = _year - 1;
    }else{
      _month = _month - 1;
    }
    _nextMonthButtonEnabled = true;
    _previousMonthButtonEnabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _month = DateTime.now().month -1;
    _year = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    List<int> _dates = _generateDates(month: _month, year: _year);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 2,
      ),
      height: SizeConfig.blockSizeVertical * 50,
      child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
//                      left: SizeConfig.blockSizeHorizontal * 9,
                      bottom: SizeConfig.blockSizeHorizontal * 2
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: _previousMonthButtonEnabled ? _setPreviousMonth : null,),
                      Text('${_getMonthName(_month)} $_year'),
                      IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: _nextMonthButtonEnabled ? _setNextMonth : null)
                    ],
                  ),
                ),
                Wrap(
                  children: _days.map((element){
                    return FractionallySizedBox(
                      widthFactor: 0.13,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                          child: Text(element, textAlign: TextAlign.center,),
                        ));
                  },
                ).toList()),
                Wrap(
                  children: _dates.map((element ) {
                    var today = '$_year-${_month + 1}-${element < 10 ? "0$element" : element }';
                    return FractionallySizedBox(
                      widthFactor: 0.13,
                      child: element == 0 ? Container() : GestureDetector(
                          onTap: (){
//                            Navigator.pop(context);
                            _onServiceDateSelected(element);
                          },
                          child: Obx((){
                            return Stack(
                              children: [
                                Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: element == Get.find<DashboardController>().serviceDay.value ?  Colors.teal : Colors.transparent,
                                      ),
                                      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                                      child: Text('$element', textAlign: TextAlign.center,)),
                                ),
                                widget.calendarPinPoints != null && widget.calendarPinPoints.contains(today) ?
                                Positioned(
                                  right: SizeConfig.blockSizeHorizontal * 5,
                                  top: SizeConfig.blockSizeHorizontal * 7.3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.teal,
                                        shape: BoxShape.circle
                                    ),
                                    width: SizeConfig.blockSizeHorizontal * 1.5,
                                    height: SizeConfig.blockSizeHorizontal * 1.5,
                                  ),
                                ) : Container()
                              ],
                            );
                          })),
                    );
                  },
                ).toList())
              ]
            )
    );
  }
}

