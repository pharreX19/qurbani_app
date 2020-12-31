import 'package:flutter/cupertino.dart';
import 'package:qurbani/providers/validate_item_model.dart';

class FeedbackValidationProvider extends ChangeNotifier{
  ValidateItem _feedbackMessage = ValidateItem(value: null, error: null);

  TextEditingController feedbackMessageController = TextEditingController();

  ValidateItem get feedbackMessage => _feedbackMessage;
  bool get isValid {
    if(feedbackMessage.value != null){
      return true;
    }
    return false;
  }

  void onChangeFeedbackMessage(String message){
    if(message.trim().isEmpty || message == null || message.trim().length < 7){
      _feedbackMessage = ValidateItem(value: null, error: 'Message should not be less than 7 characters');
    }else{
      _feedbackMessage = ValidateItem(value: message, error: null);
    }
    notifyListeners();
  }

  void resetValidation(){
    _clearFields();
    _clearValidation();
    notifyListeners();
  }

  void _clearFields(){
    feedbackMessageController.clear();
  }

  void _clearValidation(){
    _feedbackMessage = ValidateItem(value: null, error: null);
  }
}