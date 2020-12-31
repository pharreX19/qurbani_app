import 'package:flutter/material.dart';
import 'package:qurbani/providers/validate_item_model.dart';

class FeedbackValidationProvider extends ChangeNotifier {
  ValidateItem _feedback = ValidateItem(value: null, error: null);

  final TextEditingController feedbackController = TextEditingController();


  ValidateItem get feedback => _feedback;

  bool get isValid {
    if(feedback.value != null){
      return true;
    }
    return false;
  }

  void onFeedbackChanged(String message){
    if(message.trim().isEmpty || message == null || message.trim().length <= 5){
      _feedback = ValidateItem(value: null, error: 'Message should not be less than 5 characters');
    }else{
      _feedback = ValidateItem(value: message, error: null);
    }
    notifyListeners();
  }

  void resetValues(){
    _clearTextFields();
    _clearValidations();
    notifyListeners();
  }

  void _clearTextFields(){
    feedbackController.clear();
  }

  void _clearValidations(){
    _feedback = ValidateItem(value: null, error: null);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

