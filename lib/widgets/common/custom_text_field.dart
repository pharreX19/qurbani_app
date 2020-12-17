import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final dynamic leading;
  final bool enabled;

  CustomTextField({this.hintText, this.leading, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
        enabled: enabled,
        maxLength: 100,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 2,
            horizontal: SizeConfig.blockSizeVertical * 2,
          ),
          fillColor: Colors.grey[100],
          filled: true,
          hintText: hintText,
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
