import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NameSettingsController extends GetxController{
  RxMap<dynamic, dynamic> name  = {}.obs;
  RxString arabicNameFieldError = ''.obs;
  RxString englishNameFieldError = ''.obs;
  RxString dhivehiNameFieldError = ''.obs;
  RxString nameMeaningFieldError = ''.obs;
  RxString nameGenderFieldError = ''.obs;

  // TextEditingController arabicNameController;
  // TextEditingController englishNameController;
  // TextEditingController dhivehiNameController;
  // TextEditingController nameMeaningController;
  RxList<dynamic> nameGender = ['Male'].obs;
  String gender;

  @override
  void onInit() {
    super.onInit();
    // arabicNameController = TextEditingController();
    // englishNameController = TextEditingController();
    // dhivehiNameController = TextEditingController();
    // nameMeaningController = TextEditingController();
  }

  @override
  void dispose() {
    // arabicNameController.dispose();
    // englishNameController.dispose();
    // dhivehiNameController.dispose();
    // nameMeaningController.dispose();
    super.dispose();
  }

  void setName(Map<String, dynamic> selectedName){
    name.assignAll(selectedName);
  }

  void updateSelectedName(String key, dynamic newValue){
    name.update(key, (value) => newValue);
  }

  void onEnglishNameChanged(String name){
    if(name.trim().isEmpty){
      englishNameFieldError.value = 'Name is English is required!';
    }else{
      englishNameFieldError.value = '';
      updateSelectedName('name_en' , name);
    }
  }

  void onArabicNameChanged(String name){
    if(name.trim().isEmpty){
      arabicNameFieldError.value = 'Name is Arabic is required!';
    }else {
      arabicNameFieldError.value = '';
      updateSelectedName('name_ar', name);
    }
  }

  void onDhivehiNameChanged(String name){
    if(name.trim().isEmpty){
      dhivehiNameFieldError.value = 'Name is Dhivehi is required!';
    }else {
      dhivehiNameFieldError.value = '';
      updateSelectedName('name_dh', name);
    }
  }

  void onNameMeaningChanged(String meaning){
    if(meaning.trim().isEmpty){
      nameMeaningFieldError.value = 'Name meaning is required!';
    }else {
      nameMeaningFieldError.value = '';
      updateSelectedName('meaning', meaning);
    }
  }

  void onNameGenderChanged(String selectedGender){
      if(nameGender.contains(selectedGender)){
        nameGender.removeWhere((element) => element.toString().toLowerCase() == selectedGender.toLowerCase());
      }else{
        nameGender.insert(nameGender.length, selectedGender);
      }
      switch(nameGender.length) {
        case 0:
          nameGenderFieldError.value = 'Gender is required!';
          gender = null;
          break;
        case 1:
          gender = nameGender[0];
          nameGenderFieldError.value = '';
          break;
        case 2:
          gender = 'both';
          nameGenderFieldError.value = '';
      }
      updateSelectedName('gender', gender);
  }

  void onNameOriginChanged(String meaning){
    updateSelectedName('origin', meaning);
  }

  void updateOrRegisterName(){
    checkValidation();

  }

  bool checkValidation(){
    onEnglishNameChanged(name['name_en']);
    onArabicNameChanged(name['name_ar']);
    onDhivehiNameChanged(name['name_dh']);
    onNameMeaningChanged(name['meaning']);
    onNameOriginChanged(name['origin']);

    if(englishNameFieldError.value == null && dhivehiNameFieldError.value == null && arabicNameFieldError.value == null &&
        nameMeaningFieldError.value == null && nameGenderFieldError == null){
      return true;
    }
    return false;
  }
}