import 'package:flutter/material.dart';
import 'package:qurbani/providers/validate_item_model.dart';

class LoginValidationProvider extends ChangeNotifier {
  ValidateItem _name = ValidateItem(value: null, error: null);
  ValidateItem _contact = ValidateItem(value: null, error: null);
  ValidateItem _email = ValidateItem(value: null, error: null);
  ValidateItem _password = ValidateItem(value: null, error: null);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  ValidateItem get name => _name;
  ValidateItem get contact => _contact;
  ValidateItem get email => _email;
  ValidateItem get password => _password;


  bool get isValid {
    if(name.value != null && contact.value != null && email.value != null && password.value != null){
      return true;
    }
    return false;
  }

  void onNameChanged(String name){
    if(name.trim().isEmpty || name == null || name.trim().length <= 5){
      _name = ValidateItem(value: null, error: 'Name should not be less than 5 characters');
    }else{
      _name = ValidateItem(value: name, error: null);
    }
    notifyListeners();
  }

  void onContactChanged(String contact){
    if(contact.trim().isEmpty || contact == null || contact.trim().length < 7){
      _contact = ValidateItem(value: null, error: 'Contact number should not be less than 7 characters');
    }else{
      _contact = ValidateItem(value: contact, error: null);
    }
    notifyListeners();
  }

  void onEmailChanged(String email){
    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if(email.trim().isEmpty || email == null || email.trim().length <= 5 || !emailRegExp.hasMatch(email)){
      _email = ValidateItem(value: null, error: 'A valid email is required');
    }else{
      _email = ValidateItem(value: email, error: null);
    }
    notifyListeners();
  }

  void onPasswordChanged(String password){
    if(password.trim().isEmpty || password == null || password.trim().length <= 5){
      _password = ValidateItem(value: null, error: 'Password should not be less than 5 characters');
    }else{
      _password = ValidateItem(value: password, error: null);
      onNameChanged('Administrator'); //Setting name field when admin tries to login;
    }
    notifyListeners();
  }

  void resetValues(){
    _clearTextFields();
    _clearValidations();
    notifyListeners();
  }

  void _clearTextFields(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    contactController.clear();
  }

  void _clearValidations(){
    _name = ValidateItem(value: null, error: null);
    _email = ValidateItem(value: null, error: null);
    _contact = ValidateItem(value: null, error: null);
    _password = ValidateItem(value: null, error: null);

  }
}

