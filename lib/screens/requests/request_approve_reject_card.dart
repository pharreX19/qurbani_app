import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/requests/request_approve_reject_button.dart';
import 'package:qurbani/screens/requests/request_options_bottom_sheet.dart';

class RequestApproveRejectCard extends StatelessWidget {
  final bool isSelected;
  final int index;

  RequestApproveRejectCard({this.isSelected, this.index});

  Widget _buildOptionButtons(){
    if(isSelected){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RequestApproveRejectButton(
              title: 'Approve',
              icon: Icons.check,
              color: Colors.teal,
              onPressed: () {}),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 2,
          ),
          RequestApproveRejectButton(
              title: 'Reject',
              icon: Icons.close,
              color: Colors.red,
              onPressed: () {}),
        ],
      );
    }else {
      return Row(
        children: [
          RequestApproveRejectButton(
              title: 'Complete',
              icon: Icons.done_all,
              color: Colors.teal,
              onPressed: () {}),
        ],
      );
    }
  }

  Widget _buildMoreIconButton(BuildContext context){
    return Positioned(
      right: -5,
      top: 0,
      child: isSelected ? Container() :
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
              context: context, builder: (context){
            return RequestOptionsBottomSheet();
          });
        },
      ),
    );
  }

  Widget _buildCardContent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ali Ahmed - 7654321'),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        Text('Aqeeqah'),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 1),
          child: Text('Quantity 2'),
        ),
        Text('12 December 2020'),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        _buildOptionButtons()
      ],
    );
  }

  Widget _buildMainCard(){
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeConfig.blockSizeVertical * 2,
      ),
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeHorizontal * 3,
          horizontal: SizeConfig.blockSizeHorizontal * 5),
      width: SizeConfig.blockSizeHorizontal * 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey[300])),
      child: _buildCardContent()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMainCard(),
        _buildMoreIconButton(context)
      ],
    );
  }
}
