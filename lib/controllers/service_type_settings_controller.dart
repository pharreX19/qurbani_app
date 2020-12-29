import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/services/api_service.dart';

class ServiceTypeSettingsController extends GetxController{
  final Query serviceCollection = FirebaseFirestore.instance.collection('services');
//  RxMap<dynamic, dynamic> selectedServiceType = {}.obs;
  // RxList<dynamic> serviceTypes = [].obs;
//  RxString selectedServicePriceFieldError = ''.obs;
//  RxString selectedServiceTypeName = 'Service type'.obs;
  RxDouble selectedServiceTypePrice = RxDouble(0.0);
//  RxString selectedServiceTypeId = ''.obs;
//  RxBool selectedServiceTypeIsActive = true.obs;
  RxString serviceTypePriceFieldError = ''.obs;
  String serviceName;
  DocumentSnapshot documentSnapshot;

  @override
  onClose(){
  }

  @override
  void onInit() {
    super.onInit();
    // fetchServiceTypes();
  }

  void setInitValues(Map<String, dynamic> initObj){
    serviceName = initObj['serviceName'];
    documentSnapshot = initObj['document'];
  }

  Stream<QuerySnapshot> get serviceTypes {

    return documentSnapshot.reference.collection(serviceName).snapshots();
    return FirebaseFirestore.instance.collection('services').doc('Pc2gNRB2JRIYrHzQuKxT').collection('sadaqat').snapshots();
  }

//  Future<List<dynamic>> fetchServiceTypes() async{
//    dynamic response = await ApiService.instance.fetchAllServiceTypes('services/Pc2gNRB2JRIYrHzQuKxT/sadaqat');
    // selectedServiceType.assignAll(response[0]);
    // serviceTypes.assignAll(response);
//    return response;
//  }

//  void updateSelectedService(String key, dynamic value){
//    selectedServiceType[key] = value;
//  }

  void onServicePriceChanged(String price){
//    if(price.isNum && double.parse(price) > 0){
//      selectedServiceTypePrice.value  = double.parse(price);
//      selectedServicePriceFieldError.value = '';
//    }else{
//      selectedServicePriceFieldError.value = 'Price should be greater than zero';
//    }
  }

  Future<void> updateServiceType(Map<String, dynamic> serviceType ,BuildContext context) async{
   if(serviceType['price'].toString().isEmpty || double.tryParse(serviceType['price']) == null || double.tryParse(serviceType['price']) <= 0){
     serviceTypePriceFieldError.value = 'Price should be greater than zero';
   }else{
     try{
       dynamic response = await ApiService.instance.updateServiceType(
           'services/${documentSnapshot.id}/$serviceName/${serviceType['id']}', {'price': double.parse(serviceType['price']), 'is_active' : serviceType['is_active']});
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Service type updated successfully!'), duration: Duration(milliseconds: 500),));
       serviceTypePriceFieldError.value = '';
     }catch(e){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred, please try again! $e'),));
     }
   }
  }
}