import 'package:flutter/material.dart';
import 'package:qurbani/providers/validate_item_model.dart';

class ServiceTypeValidationProvider extends ChangeNotifier{
  ValidateItem _serviceTypeName = ValidateItem(value: null, error: null);
  ValidateItem _serviceTypePrice = ValidateItem(value: null, error: null);
  ValidateItem _serviceTypeStatus = ValidateItem(value: false, error: null);
  ValidateItem _serviceTypeId = ValidateItem(value: null, error: null);

  TextEditingController serviceTypeNameController = TextEditingController();
  TextEditingController serviceTypePriceController = TextEditingController();

  ValidateItem get serviceTypeId => _serviceTypeId;
  ValidateItem get serviceTypeName => _serviceTypeName;
  ValidateItem get serviceTypePrice => _serviceTypePrice;
  ValidateItem get serviceTypeStatus => _serviceTypeStatus;
  bool get isValid {
    if(_serviceTypeId.value != null && _serviceTypeName.value != null && _serviceTypePrice.value != null &&
        _serviceTypeStatus != null){
      return true;
    }
    return false;
  }

  void onChangeServiceTypeId(String id){
    if (id == null || id.trim().isEmpty) {
      _serviceTypeId = ValidateItem(value: null, error: 'Service type ID required!');
    } else {
      _serviceTypeId = ValidateItem(value: id, error: null);
    }
    notifyListeners();
  }

  void onChangeServiceTypeName(String name){
    if (name == null || name.trim().isEmpty) {
      _serviceTypeName = ValidateItem(value: null, error: 'Service type is required!');
    } else {
      _serviceTypeName = ValidateItem(value: name, error: null);
    }
    notifyListeners();
  }

  void onChangeServiceTypePrice(String price){
    if (price == null || price.trim().isEmpty) {
      _serviceTypePrice = ValidateItem(value: null, error: 'Service price is required!');
    }else if(double.tryParse(price) == null || double.tryParse(price) <= 0){
      _serviceTypePrice = ValidateItem(value: null, error: 'Price cannot be less than 1!');
    } else {
      _serviceTypePrice = ValidateItem(value: double.parse(price), error: null);
    }
    notifyListeners();
  }

  void onChangeServiceTypStatus(bool isActive){
      _serviceTypeStatus = ValidateItem(value: isActive, error: null);
      notifyListeners();
  }

  void resetValues(){
    clearTextFields();
    clearValidations();
    notifyListeners();
  }

  void clearTextFields(){
    serviceTypeNameController.clear();
    serviceTypePriceController.clear();
  }

  void clearValidations(){
    _serviceTypeId = ValidateItem(value: null, error: null);
    _serviceTypePrice = ValidateItem(value: _serviceTypePrice.value, error: null);
  }
}