import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/services/api_service.dart';

class ServiceSettingsController extends GetxController{
  final Query serviceCollection = FirebaseFirestore.instance.collection('services');
  RxMap<dynamic, dynamic> selectedServiceType = {}.obs;
  final TextEditingController servicePriceController = TextEditingController();

  @override
  onClose(){
    servicePriceController.dispose();
  }

  Stream<QuerySnapshot> get services {
    return serviceCollection.snapshots();
  }

  void updateSelectedService(String key, dynamic value){
    selectedServiceType[key] = value;
  }

  void onServicePriceChanged(String price){
    updateSelectedService('price', double.parse(price));
  }

  Future<void> updateServiceType(Map<String, dynamic> service, BuildContext context) async{
    try{
      dynamic response = await ApiService.instance.updateServiceType(
          'services/${service['id']}/${service['name'].toString().toLowerCase()}/${selectedServiceType['id']}', selectedServiceType.value);
      servicePriceController.text = '';
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Service type updated successfully!'),));
    }catch(e){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('An error occurred, please try again!'),));
    }
  }
}