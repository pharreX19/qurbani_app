import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/request/request_form.dart';

class DashboardController extends GetxController{
  String serviceType;
  DateTime serviceDate;
  String childName;
  int contactNo;
  RxInt serviceQuantity = 1.obs;
  RxString receiptPath =''.obs;
  RxDouble totalPrice = 0.0.obs;
  TextEditingController childNameController;
  TextEditingController contactNumberController;
  double unitPrice;
  RxInt serviceDay = DateTime.now().day.obs;
  RxString childNameFieldError = ''.obs;
  RxString contactNumberFieldError = ''.obs;
  RxString receiptUploadFieldError = ''.obs;
  final imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    childNameController = TextEditingController();
    contactNumberController = TextEditingController();
    getAllServices();
  }

  @override
  void dispose() {
    childNameController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }
  
  getAllServices() async{
    FirebaseFirestore.instance.collection('services').get().then((value) => print(value.docs));
  }

  void onServiceTypeSelectedCallback(BuildContext context, String serviceName){
//    _requestedService = serviceType;
    setRequestedServiceType(serviceName);
    showModalBottomSheet(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8.0),
      ),
    ), context: context, builder: (context){
      return CalendarBottomSheet(onDateSelectedCallback: (){
        _onDateSelectedCallback(context);
      },);
    });
  }

  void _onDateSelectedCallback(BuildContext context){
//    _requestServiceDate = DateTime(_year, _month, date);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestForm()));//(requestedServiceDate: _requestServiceDate, requestedService: _requestedService)));
//    showModalBottomSheet(shape: RoundedRectangleBorder(
//      borderRadius: BorderRadius.vertical(
//        top: Radius.circular(8.0),
//      ),
//    ), context: context, builder: (context){
//      return RequestForm(requestedServiceDate: _requestServiceDate, requestedService: _requestedService,);
//    });
  }

  void setChildName(String name){
    childName = name;
  }


  void setRequestedServiceType(String serviceName){
    serviceType = serviceName;
    setUnitPrice(700);
  }


  void setUnitPrice(double price){
    unitPrice = price;
    setTotalPrice();
  }

  void setTotalPrice(){
    print('Quantity is $serviceQuantity');
    totalPrice.value = unitPrice * serviceQuantity.value;
  }

  void setRequestedServiceDate(int day){
     int year = DateTime.now().year;
     int month = DateTime.now().month;
    serviceDate = DateTime(year, month, day);
     setServiceDay(day);
  }

  void setServiceQuantity(int quantity){
    print('hello word quantity: $quantity');
    serviceQuantity.value = quantity;
    setTotalPrice();
  }

  void setServiceDay(int day){
    serviceDay.value = day;
  }

  void onChangedChildNameTextField(String value){
    childNameFieldError.value = '';
  }

  void onChangedContactNumberTextField(String value){
    contactNumberFieldError.value = '';
  }

  void submitRequestForm(){
    if(childNameController.text.isEmpty){
      childNameFieldError.value = 'Child\'s name is required!';
    }
    if(contactNumberController.text.isEmpty){
      contactNumberFieldError.value = 'Contact number is required!';
    }
    if(receiptPath.value.isEmpty){
      receiptUploadFieldError.value = 'No receipt found!';
    }
  }

  void clearErrors(){
    receiptUploadFieldError.value = '';
  }

  void pickReceiptImage() async{
    final PickedFile pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    if(pickedImage.path.isNotEmpty){
      receiptPath.value = pickedImage.path;
      receiptUploadFieldError.value = '';
    }
  }
}