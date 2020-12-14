import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/widgets/common/custom_app_bar.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {

  List<Icon> _toggleButtonIcons = [
    Icon(Icons.playlist_add_check),
    Icon(Icons.playlist_play)
  ];

  List<bool> _isSelected = [
    true,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MainLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Requests'),
              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
              Center(
                child: ToggleButtons(
                  constraints: BoxConstraints(
                    maxHeight: SizeConfig.blockSizeVertical * 4,
                    minWidth: SizeConfig.blockSizeHorizontal * 46
                  ),
                  children: _toggleButtonIcons,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
                        if (buttonIndex == index) {
                          _isSelected[buttonIndex] = true;
                        } else {
                          _isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: _isSelected,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, int index){
                    return Container(
                      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2, top: index == 0 ? SizeConfig.blockSizeVertical * 2 : 0),
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeHorizontal * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 5
                      ),
                      width: SizeConfig.blockSizeHorizontal * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey[300])
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Aqeeqah'),
                              Icon(Icons.more_vert),
                            ],
                          ),
                          Text('Quantity 2'),
                          Text('12 December 2020'),
                          Text('Ali Ahmed, '),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(onPressed: (){}, child: Text('Approve'), color: Colors.teal,),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                              RaisedButton(onPressed: (){}, child: Text('Approve'), color: Colors.red,)
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
