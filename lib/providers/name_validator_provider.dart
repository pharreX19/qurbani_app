import 'package:flutter/material.dart';
import 'package:qurbani/providers/validate_item_model.dart';

class NameValidationProvider extends ChangeNotifier {
  ValidateItem _nameInArabic = ValidateItem(value: null, error: null);
  ValidateItem _nameInDhivehi = ValidateItem(value: null, error: null);
  ValidateItem _nameInEnglish = ValidateItem(value: null, error: null);
  ValidateItem _nameMeaning = ValidateItem(value: null, error: null);
  ValidateItem _nameOrigin = ValidateItem(value: 'Arabic', error: null);
  ValidateItem _nameGender = ValidateItem(value: ['Male'], error: null);

  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController dhivehiNameController = TextEditingController();
  final TextEditingController nameMeaningController = TextEditingController();


  ValidateItem get nameInArabic => _nameInArabic;
  ValidateItem get nameInDhivehi => _nameInDhivehi;
  ValidateItem get nameInEnglish => _nameInEnglish;
  ValidateItem get nameMeaning => _nameMeaning;
  ValidateItem get nameOrigin => _nameOrigin;
  ValidateItem get nameGender => _nameGender;
  bool get isValid {
    if(nameInArabic.value != null && nameInDhivehi.value != null && nameInEnglish.value != null && nameMeaning.value != null
     && nameOrigin.value != null && nameGender.value != null){
      return true;
    }
    return false;
  }

  void onArabicNameChanged(String name) {
    if (name == null || name.trim().isEmpty) {
      _nameInArabic = ValidateItem(value: null, error: 'Name is Arabic is required!');
    } else {
      _nameInArabic = ValidateItem(value: name, error: null);
    }
    notifyListeners();
  }

  void onDhivehiNameChanged(String name) {
    if (name == null || name.trim().isEmpty) {
      _nameInDhivehi = ValidateItem(value: null, error: 'Name is Dhivehi is required!');
    } else {
      _nameInDhivehi = ValidateItem(value: name, error: null);
    }
    notifyListeners();
  }

  void onEnglishNameChanged(String name) {
    if (name == null || name.trim().isEmpty) {
      _nameInEnglish = ValidateItem(value: null, error: 'Name is English is required!');
    } else {
      _nameInEnglish = ValidateItem(value: name, error: null);
    }
    notifyListeners();
  }

  void onNameMeaningChanged(String name) {
    if (name == null || name.trim().isEmpty) {
      _nameMeaning = ValidateItem(value: null, error: 'Name Meaning is required!');
    } else {
      _nameMeaning = ValidateItem(value: name, error: null);
    }
    notifyListeners();
  }

  void onNameOriginChanged(String origin) {
    if (origin == null || origin.trim().isEmpty) {
      _nameOrigin = ValidateItem(value: null, error: 'Name Origin is required!');
    } else {
      _nameOrigin = ValidateItem(value: origin, error: null);
    }
    notifyListeners();
  }

  void onNameGenderChanged(String gender, bool value) {
    if(value){
      List<String> temp = List.from(nameGender.value);
      temp.add(gender);
      _nameGender = ValidateItem(value: temp, error: null);
    }else{
      nameGender.value.remove(gender);
      if (nameGender.value.length <= 0) {
        _nameGender = ValidateItem(value: [], error: 'Name gender is required!');
      }
    }
    notifyListeners();
  }

  void resetValues(){
    clearTextFields();
    clearValidations();
    notifyListeners();
  }

  void clearTextFields(){
    arabicNameController.clear();
    dhivehiNameController.clear();
    englishNameController.clear();
    nameMeaningController.clear();
  }

  void clearValidations(){
    _nameInArabic = ValidateItem(value: null, error: null);
    _nameInDhivehi = ValidateItem(value: null, error: null);
    _nameInEnglish = ValidateItem(value: null, error: null);
    _nameMeaning = ValidateItem(value: null, error: null);
    _nameOrigin = ValidateItem(value: 'Arabic', error: null);
    _nameGender = ValidateItem(value: ['Male'], error: null);
  }
}
