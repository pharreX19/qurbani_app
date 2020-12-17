import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/requests/admin/request_approve_reject_button.dart';
import 'package:qurbani/screens/requests/admin/request_approve_reject_card.dart';
import 'package:qurbani/widgets/common/custom_app_bar.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  PageController _pageController = PageController(viewportFraction: 0.9);
  final List<Map<String, dynamic>> requestStats = [
    {'title': 'Pending', 'icon': Icons.bar_chart, 'count': 2},
    {'title': 'Completed', 'icon': Icons.insert_chart_outlined, 'count': 6}
  ];
  var _currentPageValue = 0.0;

  Widget _buildRequestStats(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:
        requestStats.map((element){
          return Column(
            children: [
              Row(
                children: [
                  Text(element['count'].toString()),
                  Icon(element['icon']),
                ],
              ),
              Text(element['title'])
            ],
          );
        }).toList()
    );
  }

  Widget _buildRequestList() {
    return Column(
      children: [
      Container(
        height: SizeConfig.blockSizeVertical * 30,
        child: PageView.builder(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        itemCount: 4,
          itemBuilder: (context, int index){
          if(index == _currentPageValue.floor()){
            return Transform(
              transform: Matrix4.identity()..rotateX(_currentPageValue - index),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.red : Colors.black45
                ),
              ),
            );
          } else if(index == _currentPageValue.floor() + 1){
            return Transform(
              transform: Matrix4.identity()..rotateX(_currentPageValue - index),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.red : Colors.black45
                ),
              ),
            );
          } else{
            return Container(
              margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
              decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.red : Colors.black45
              ),
            );
          }
          },
        ),
      ),
      ],
    );
  }
  
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MainLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Requests'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              _buildRequestStats(),
              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
              _buildRequestList(),
            ],
          ),
        ),
      ),
    );
  }
}
