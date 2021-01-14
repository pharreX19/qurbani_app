import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/controllers/home_controller.dart';
import 'package:qurbani/main.dart';
import 'package:qurbani/screens/authentication/welcome.dart';
import 'package:qurbani/screens/home.dart';
import 'package:qurbani/services/api_service.dart';
import 'package:qurbani/services/secure_storage.dart';

class ProfileController extends GetxController{
  // final Query adminCollection = FirebaseFirestore.instance.collection('admins');
  RxBool isSubmitting = false.obs;

  Future<String> getUserIdFromStorage()async {
    return await SecureStorage.instance.read(key: "USER_ID");
  }

  Future<DocumentSnapshot> profile(String collectionName) async{
    String userId = await getUserIdFromStorage();
    print(userId);
    return FirebaseFirestore.instance.collection(collectionName).doc(userId).get();
  }

  Future<void> logout(BuildContext context, String collection) async{
    Get.find<HomeController>().isSubmitting.value = true;
    try{
      String userId = await getUserIdFromStorage();
      dynamic response = await ApiService.instance.logout('$collection/$userId/logout');
      if(response){
        // await FirebaseAuth.instance.signOut();
        // await SecureStorage.instance.deleteAll();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Welcome()));
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred, please try again later')));
      print('An error $e');
    }finally{
        Get.find<HomeController>().isSubmitting.value = false;
    }
  }
}