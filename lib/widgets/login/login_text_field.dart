import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData icon;
  final String errorText;
  final Function onChanged;
  final int maxLength;
  final TextInputType keyboardType;

  LoginTextField(
      {
      @required this.controller,
      @required this.title,
      @required this.icon,
      @required this.errorText,
      @required this.onChanged,
      @required this.maxLength,
      @required this.keyboardType
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          labelText: title,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5.0)),
          errorText: errorText,
          errorMaxLines: 2,
          counterText: '',
      ),
      onChanged: onChanged,
      maxLength: maxLength,

    );
  }
}
