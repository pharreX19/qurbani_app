import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/globals/helpers.dart';
import 'package:qurbani/services/api_service.dart';

class NameSettingsController extends GetxController{
  final Query nameCollection = FirebaseFirestore.instance.collection('names');
  Map<dynamic, dynamic> name  = {};
  RxString arabicNameFieldError = ''.obs;
  RxString englishNameFieldError = ''.obs;
  RxString dhivehiNameFieldError = ''.obs;
  RxString nameMeaningFieldError = ''.obs;
  RxString nameGenderFieldError = ''.obs;
  // RxList<dynamic> nameGender = ['Male'].obs;
  String gender;
  RxString origin = 'Arabic'.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchAllNames();
  }

  Stream<QuerySnapshot> get names {
    return nameCollection.snapshots();
  }

  // Future<void> fetchAllNames() async{
  //   dynamic response = await ApiService.instance.getAllNames('names');
    // nameList.assignAll(response);
  // }

  void setName(Map<String, dynamic> selectedName){
    // name.assignAll(selectedName);
  }

  void updateSelectedName(String key, dynamic newValue){
    // name.update(key, (value) => newValue);
  }

  bool onEnglishNameChanged(String name){
    if(name == null ||  name.trim().isEmpty){
      englishNameFieldError.value = 'Name is English is required!';
      return false;
    }else{
      englishNameFieldError.value = '';
      // updateSelectedName('name_en' , name);
      return true;
    }
  }

  bool onArabicNameChanged(String name){
    if(name == null || name.trim().isEmpty){
      arabicNameFieldError.value = 'Name is Arabic is required!';
      return false;
    }else {
      arabicNameFieldError.value = '';
      // updateSelectedName('name_ar', name);
      return true;
    }
  }

  bool onDhivehiNameChanged(String name){
    if(name == null || name.trim().isEmpty){
      dhivehiNameFieldError.value = 'Name is Dhivehi is required!';
      return false;
    }else {
      dhivehiNameFieldError.value = '';
      // updateSelectedName('name_dh', name);
      return true;
    }
  }

  bool onNameMeaningChanged(String meaning){
    if(meaning == null || meaning.trim().isEmpty){
      nameMeaningFieldError.value = 'Name meaning is required!';
      return false;
    }else {
      nameMeaningFieldError.value = '';
      // updateSelectedName('meaning', meaning);
      return true;
    }
  }

  bool onNameGenderChanged(List<String> nameGender){
    if(nameGender.length <= 0){
      nameGenderFieldError.value = 'Gender is required!';
      return false;
    }else{
      nameGenderFieldError.value = '';
      return true;
    }
      // if(nameGender.contains(selectedGender)){
      //   nameGender.removeWhere((element) => element.toString().toLowerCase() == selectedGender.toLowerCase());
      // }else{
      //   nameGender.insert(nameGender.length, selectedGender);
      // }
      // switch(nameGender.length) {
      //   case 0:
      //     nameGenderFieldError.value = 'Gender is required!';
      //     gender = null;
      //     break;
      //   case 1:
      //     gender = nameGender[0];
      //     nameGenderFieldError.value = '';
      //     break;
      //   case 2:
      //     gender = 'both';
      //     nameGenderFieldError.value = '';
      // }
      // updateSelectedName('gender', gender);
  }

  void onNameOriginChanged(String meaning){
    updateSelectedName('origin', meaning);
  }

    void registerName(Map<String, dynamic> name, Function callback) async{
      // if(checkValidation(name)){
      //   nameList.add(name);
      //   this.nameList.refresh();
      //   print(name);
       try{
         await ApiService.instance.createName('names', name);
         callback();
       }catch(e){
         print('An error occurred');
       // }
      }
  }

  void deleteName(String id) async{
     await ApiService.instance.deleteName('names/$id');
    // nameList.removeAt(index);
    // this.nameList.refresh();
  }

  bool checkValidation(Map<String, dynamic> name){
    onEnglishNameChanged(name['name_en']);
    onArabicNameChanged(name['name_ar']);
    onDhivehiNameChanged(name['name_dh']);
    onNameMeaningChanged(name['meaning']);
    onNameOriginChanged(name['origin']);

    if(englishNameFieldError.value.isEmpty && dhivehiNameFieldError.value.isEmpty && arabicNameFieldError.value.isEmpty &&
        nameMeaningFieldError.value.isEmpty && nameGenderFieldError.value.isEmpty){
      return true;
    }
    return false;
  }



  void updateName(BuildContext context, Map<String, dynamic> name) async {
     try{
        await ApiService.instance.updateName('names/${name['id']}', toFireStoreJson(name));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name updated successfully'),));
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occured, try again'),));
      }
  }
}