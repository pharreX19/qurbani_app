import 'package:flutter/material.dart';

class SizeConfig{
  static double _screenWidth;
  static double _screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static MediaQueryData _mediaQueryData;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = _screenWidth/100;
    blockSizeVertical = _screenHeight /100;
  }
}