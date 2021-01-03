import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurbani/providers/validate_item_model.dart';

class RequestValidationProvider extends ChangeNotifier {
  ValidateItem _name = ValidateItem(value: null, error: null);
  ValidateItem _contactNo = ValidateItem(value: null, error: null);
  ValidateItem _quantity = ValidateItem(value: 1, error: null);
  ValidateItem _receipt = ValidateItem(value: null, error: null);
  ValidateItem _unitPrice = ValidateItem(value: 700, error: null);
  ValidateItem _totalPrice = ValidateItem(value: null, error: null);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  ValidateItem get name => _name;
  ValidateItem get contactNo => _contactNo;
  ValidateItem get quantity => _quantity;
  ValidateItem get receipt => _receipt;
  ValidateItem get unitPrice => _unitPrice;
  ValidateItem get totalPrice => _totalPrice;


  bool get isValid {
    if(name.value != null && contactNo.value != null && receipt.value != null){
      return true;
    }
    return false;
  }

  void onChangedName(String name){
    if(name.trim().isEmpty || name == null){
      _name = ValidateItem(value: null, error: 'Name is required');
    }else{
      _name = ValidateItem(value: name, error: null);
    }
    notifyListeners();
  }

  void onChangedContactNumber(String contactNo){
    if(contactNo.trim().isEmpty || contactNo == null){
      _contactNo = ValidateItem(value: null, error: 'Contact number is required');
    }
    if(contactNo.trim().length < 7 || int.tryParse(contactNo) == null){
      _contactNo = ValidateItem(value: null, error: 'Contact number should be greater than 7 digits');
    }
    else{
      _contactNo = ValidateItem(value: contactNo, error: null);
    }
    notifyListeners();
  }

  void onChangedQuantity(int quantity){
    if(quantity == null){
      _quantity = ValidateItem(value: null, error: 'Message should not be less than 5 characters');
    }else{
      _quantity = ValidateItem(value: quantity, error: null);
    }
    notifyListeners();
  }

  void onChangedReceiptUrl() async{
    print('image picking');
    ImagePicker imagePicker = ImagePicker();
    final PickedFile pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    if(pickedImage != null && pickedImage.path.isNotEmpty){
      // receiptPath.value = pickedImage.path;
      // File receipt = File(pickedImage.path);
      // List<int> imageBytes = receipt.readAsBytesSync();
      // receiptUrl.value = base64Encode(imageBytes);
      _receipt = ValidateItem(value: pickedImage.path, error: null);
    }else{
      print('NO IMGAE FOUND');
      _receipt = ValidateItem(value: null, error: 'Bank receipt is required');
    }
    notifyListeners();
  }

  // void onChangedUnitPrice(double unitPrice){
  //   if(unitPrice != null){
  //     _unitPrice = ValidateItem(value: null, error: 'Message should not be less than 5 characters');
  //   }else{
  //     _unitPrice = ValidateItem(value: unitPrice, error: null);
  //   }
  //   notifyListeners();
  // }

  void resetValues(){
    _clearTextFields();
    _clearValidations();
    notifyListeners();
  }

  void _clearTextFields(){
    nameController.clear();
    contactNumberController.clear();
  }

  void _clearValidations(){
    _name = ValidateItem(value: null, error: null);
    _contactNo = ValidateItem(value: null, error: null);
    _receipt = ValidateItem(value: null, error: null);

  }

  @override
  void dispose() {
    super.dispose();
  }
}

