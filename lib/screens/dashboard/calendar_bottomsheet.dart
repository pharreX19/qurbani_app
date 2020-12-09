import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class CalendarBottomSheet extends StatelessWidget {
  final Function onDateSelectedCallback;
  final int month;
  final int year;
  CalendarBottomSheet({this.onDateSelectedCallback, this.month, this.year});

  final List<String> _days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<int> _daysCount = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  final List<String> _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

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
    print(dates);
  }

  @override
  Widget build(BuildContext context) {
    List<int> _dates = _generateDates(month: month, year: year);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 2,
      ),
      height: SizeConfig.blockSizeVertical * 40,
      child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 9,
                      bottom: SizeConfig.blockSizeHorizontal * 2
                  ),
                  child: Row(
                    children: [
                      Text(_getMonthName(month)),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Text('$year')
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
                    return FractionallySizedBox(
                      widthFactor: 0.13,
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                        child: element == 0 ? Container() : GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              onDateSelectedCallback(element);
                            },
                            child: Text('$element', textAlign: TextAlign.center,)),
                      ),
                    );
                  },
                ).toList())
              ]
            )
    );
  }
}
