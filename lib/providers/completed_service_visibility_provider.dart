import 'package:flutter/cupertino.dart';

class CompletedServiceVisibilityProvider extends ChangeNotifier{
  bool _hideCompleted = true;

  bool get hideCompleted => _hideCompleted;

  void toggleHideCompleted(){
    _hideCompleted = !hideCompleted;
    notifyListeners();
}
}