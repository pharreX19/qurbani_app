import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function callback;

  CustomAppBar({this.callback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}
