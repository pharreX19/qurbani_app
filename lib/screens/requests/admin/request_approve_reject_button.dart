import 'package:flutter/material.dart';

class RequestApproveRejectButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Function onPressed;

  RequestApproveRejectButton({this.title, this.icon, this.color, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton.icon(
        elevation: 0.5,
        onPressed: (){
          onPressed();
        },
        icon: Icon(icon, color: color,),
        label: Text(title, style: TextStyle(color: color),), color: Colors.grey[100],
      )
    );
  }
}
