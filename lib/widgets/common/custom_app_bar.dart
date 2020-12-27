import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class CustomAppBar {
  final Function callback;

  CustomAppBar({this.callback});

  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical * 8),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
            if(callback != null){
              callback();
            }
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.teal),
      ),
    );
  }
}
