import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/controllers/upload_media_controller.dart';
import 'package:qurbani/providers/validate_item_model.dart';

class MediaUploadValidationProvider extends ChangeNotifier {
  ValidateItem _title = ValidateItem(value: null, error: null);
  ValidateItem _mediaCount = ValidateItem(value: 0, error: null);

  final TextEditingController titleController = TextEditingController();


  ValidateItem get title => _title;
  ValidateItem get mediaCount => _mediaCount;

  bool get isValid {
    print(_mediaCount.value > 0);
    if(title.value != null && _mediaCount.value > 0){
      return true;
    }
    return false;
  }

  void onTitleChanged(String title){
    if(title.trim().isEmpty || title == null || title.trim().length <= 5){
      _title = ValidateItem(value: null, error: 'Title is required and should not be less than 5 characters');
    }else{
      _title = ValidateItem(value: title, error: null);
    }
    notifyListeners();
  }

  void setMediaCount(int count){
    print('NOW COUNT IS $count');
    _mediaCount = ValidateItem(value: count, error: null);
    print('AND NOW VALUES IS ${_mediaCount.value}');
    notifyListeners();

  }

  void resetValues(){
    _clearTextFields();
    _clearValidations();
    notifyListeners();
  }

  void _clearTextFields(){
    titleController.clear();
  }

  void _clearValidations(){
    _title = ValidateItem(value: null, error: null);
  }
}

