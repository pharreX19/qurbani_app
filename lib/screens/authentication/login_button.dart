import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class LoginButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color backgroundColor;
  final Function callback;

  LoginButton({this.title, this.icon, this.backgroundColor, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        callback();
      },
      child: Container(
        margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 2.5,
        ),
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null ? Container() : Icon(icon),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            Text(title)
          ],
        ),
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.teal,
            border: backgroundColor == null ? Border.all(style: BorderStyle.none) : Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(5.0)
        ),
      ),
    );
  }
}
