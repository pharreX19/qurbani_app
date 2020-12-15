import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/requests/request_approve_reject_button.dart';
import 'package:qurbani/screens/requests/request_approve_reject_card.dart';
import 'package:qurbani/widgets/common/custom_app_bar.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  List<Icon> _toggleButtonIcons = [
    Icon(Icons.playlist_play),
    Icon(Icons.playlist_add_check),
  ];

  List<bool> _isSelected = [true, false];

  Widget _buildRequestList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, int index) {
          return RequestApproveRejectCard(isSelected: _isSelected[0], index: index);
        },
      ),
    );
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
              Text('Requests'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Center(
                child: ToggleButtons(
                  constraints: BoxConstraints(
                      maxHeight: SizeConfig.blockSizeVertical * 4,
                      minWidth: SizeConfig.blockSizeHorizontal * 46),
                  children: _toggleButtonIcons,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < _isSelected.length;
                          buttonIndex++) {
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
              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
              _isSelected[0] ? _buildRequestList() : _buildRequestList(),
            ],
          ),
        ),
      ),
    );
  }
}
