import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class SubmitButton extends StatelessWidget {
  final Function submitCallback;
  final String title;
  final IconData icon;

  SubmitButton({this.submitCallback, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: SizeConfig.blockSizeHorizontal * 95,
      height: SizeConfig.blockSizeVertical * 5,
      child: RaisedButton.icon(
        onPressed: (){
          if(submitCallback != null){
            submitCallback();
          }
        },
        label: Text(title),
        icon: Icon(icon),
      ),
      buttonColor: Colors.teal,
      textTheme: ButtonTextTheme.primary,
    );
  }
}
