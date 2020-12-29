import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/services/api_service.dart';

class ServiceTypeSettingsController extends GetxController{
  final Query serviceCollection = FirebaseFirestore.instance.collection('services');
  RxMap<dynamic, dynamic> selectedServiceType = {}.obs;
  final TextEditingController servicePriceController = TextEditingController();
  // RxList<dynamic> serviceTypes = [].obs;
  RxString selectedServicePriceFieldError = ''.obs;
  RxString selectedServiceTypeName = ''.obs;
  RxDouble selectedServiceTypePrice = 0.0.obs;
  RxString selectedServiceTypeId = ''.obs;
  RxBool selectedServiceTypeIsActive = true.obs;


  @override
  onClose(){
    servicePriceController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    // fetchServiceTypes();
  }

  Stream<QuerySnapshot> get serviceTypes {
    return FirebaseFirestore.instance.collection('services').doc('Pc2gNRB2JRIYrHzQuKxT').collection('sadaqat').snapshots();
  }

  Future<List<dynamic>> fetchServiceTypes() async{
    dynamic response = await ApiService.instance.fetchAllServiceTypes('services/Pc2gNRB2JRIYrHzQuKxT/sadaqat');
    // selectedServiceType.assignAll(response[0]);
    // serviceTypes.assignAll(response);
    return response;
  }

  void updateSelectedService(String key, dynamic value){
    selectedServiceType[key] = value;
  }

  void onServicePriceChanged(String price){
    if(price.isNum && double.parse(price) > 0){
      updateSelectedService('price', double.parse(price));
      selectedServicePriceFieldError.value = '';
    }else{
      selectedServicePriceFieldError.value = 'Price should be greater than zero';
    }
  }

  Future<void> updateServiceType(Map<String, dynamic> service, BuildContext context) async{
    try{
      dynamic response = await ApiService.instance.updateServiceType(
          'services/Pc2gNRB2JRIYrHzQuKxT/sadaqat/FwPb8N0RUDZ88H8L9Lwd', {'is_active': false});
      servicePriceController.text = '';
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Service type updated successfully!'),));
    }catch(e){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('An error occurred, please try again!'),));
    }
  }
}