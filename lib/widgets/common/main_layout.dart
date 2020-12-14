import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  MainLayout({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 3,
        right: SizeConfig.blockSizeHorizontal * 3,
        top: SizeConfig.blockSizeVertical * 3
    ),
      child: child,
    );
  }
}
