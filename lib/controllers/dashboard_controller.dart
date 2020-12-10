import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  String serviceType;
  DateTime serviceDate;
  String childName;
  int contactNo;
  int serviceQuantity = 1.obs as int;
  String receiptPath =''.obs as String;
  double totalPrice = 0.0.obs as double;
  TextEditingController childNameController;
  TextEditingController contactNumberController;
  double unitPrice;


  @override
  void onInit() {
    super.onInit();
    childNameController = TextEditingController();
    contactNumberController = TextEditingController();
  }

  @override
  void dispose() {
    childNameController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }


  void setRequestedServiceType(String serviceName){
    serviceType = serviceName;
    setUnitPrice(700);
  }


  void setUnitPrice(double price){
    unitPrice = price;
  }

  void setTotalPrice(){
    totalPrice = unitPrice * serviceQuantity;
  }

  void setRequestedServiceDate(int day){
     int year = DateTime.now().year;
     int month = DateTime.now().month;
    serviceDate = DateTime(year, month+1, day);
  }


  void setServiceQuantity(int quantity){
    serviceQuantity = quantity;
  }

}