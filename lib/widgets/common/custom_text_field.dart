import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final dynamic leading;
  final bool enabled;
  final TextDirection textDirection;
  final IconData suffixIcon;
  final int maxLines;
  final int maxLength;
  final TextEditingController controller;
  final Function onChanged;
  final String errorText;

  CustomTextField(
      {this.hintText,
      this.leading,
      this.enabled = true,
      this.textDirection = TextDirection.ltr,
      this.maxLines = 1,
      this.suffixIcon,
        this.controller,
        this.onChanged,
        this.errorText,
      this.maxLength = 50});

  @override
  Widget build(BuildContext context) {
    return TextField(
        enabled: enabled,
        maxLength: maxLength,
        maxLines: maxLines,
        controller: controller,
        keyboardType: TextInputType.name,
        textDirection: textDirection,
        onChanged: (value){
          if(onChanged != null){
            onChanged(value);
          }
        },
        decoration: InputDecoration(
          errorText: errorText,
          contentPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 2,
            horizontal: SizeConfig.blockSizeVertical * 2,
          ),
          fillColor: Colors.grey[100],
          filled: true,
          hintText: hintText,
          suffixIcon: Icon(
            suffixIcon,
            color: Colors.grey[400],
          ),
          prefix: leading,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(4.0)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintStyle: TextStyle(color: Colors.grey[500]),
          counterText: '',
        ));
  }
}
