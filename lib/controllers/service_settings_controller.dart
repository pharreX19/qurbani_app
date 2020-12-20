import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ServiceSettingsController extends GetxController{
  // RxMap<dynamic, dynamic> service  = {}.obs;
  // TextEditingController serviceTypeController;
  // TextEditingController servicePriceController;
  RxList<Map<String, dynamic>> serviceTypes = [
    {'name' : 'Goat', 'price' : 1100, 'isActive': true},
    {'name' : 'Cow', 'price' : 1300, 'isActive': true},
    {'name' : 'Sheep', 'price' : 100, 'isActive': true},
    {'name' : 'Camel', 'price' : 1500, 'isActive': false},
    {'name' : 'Others', 'price' : 2000, 'isActive': true},
  ].obs;

  RxString service = ''.obs;
  RxMap<dynamic, dynamic> selectedServiceType = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // serviceTypeController = TextEditingController(text: '');
    // servicePriceController = TextEditingController(text: '');
    selectedServiceType.assignAll(serviceTypes[0]);
  }

  @override
  void dispose() {
    // servicePriceController.dispose();
    // serviceTypeController.dispose();
    super.dispose();
  }

  void setServiceType(String selectedService){
    // service.assignAll(selectedServiceType);
    service.value = selectedService;
  }

  void updateSelectedService(String key, dynamic value){
    selectedServiceType[key] = value;
    // service.update(key, (value) => newValue);
  }

  void onServiceTypeChanged(String name){
    updateSelectedService('name' , name);
  }

  void onServicePriceChanged(String price){
    updateSelectedService('price', double.parse(price));
  }

  void updateService(){
    print(selectedServiceType);
  }
}