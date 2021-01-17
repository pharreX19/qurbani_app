import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurbani/controllers/requests_controller.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/dashboard/user/dashboard.dart';
import 'package:qurbani/screens/home.dart';
import 'package:qurbani/screens/request/request_form.dart';
import 'package:qurbani/services/api_service.dart';
import 'package:qurbani/services/secure_storage.dart';

class DashboardController extends GetxController{
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  String serviceType;
  String serviceName;
  DateTime serviceDate;
  String childName;
  String contactNo;
  int serviceQuantity = 1;
  // RxInt serviceQuantity = 1.obs;
  // RxString receiptUrl =''.obs;
  // RxDouble totalPrice = 0.0.obs;
  double unitPrice;
  RxInt serviceDay = DateTime.now().day.obs;
  // RxString childNameFieldError = ''.obs;
  // RxString contactNumberFieldError = ''.obs;
  // RxString receiptUploadFieldError = ''.obs;
  RxDouble currentMonthEarning = 0.0.obs;
  // final imagePicker = ImagePicker();
  RxList<dynamic>dailyRequestsStat = [].obs;
  List<dynamic> services;
  List<dynamic> selectedServiceTypes;
  Map<String, dynamic> selectedService;
  RxList<dynamic> requests = [].obs;
   final RxList<dynamic> requestStats = [
     {'title': 'Pending', 'icon': Icons.bar_chart, 'count': 0},
     {'title': 'Completed', 'icon': Icons.insert_chart_outlined, 'count': 0},
     {'title': 'Rejected', 'icon': Icons.error_outline, 'count': 0}
   ].obs;

  @override
  void onInit() {
    super.onInit();
//    final RequestsController requestsController = Get.put(RequestsController());
//       fetchAllRequests();
//       fetchAllServices();
  }

  void initController(){
    dailyRequestsStat.assignAll([]);
    fetchAllRequests();
    fetchAllServices();
  }

  Future<void> fetchAllRequests() async{
    requests.assignAll(await ApiService.instance.fetchAllRequests('requests'));
    populateCurrentMonthEarning();
    populateCompletedAndPendingUserRequests();
  }

  Future<dynamic> fetchAllServices() async{
    return services = await ApiService.instance.fetchAllServices('services');
  }

  Future<dynamic> fetchSelectedServiceTypes(Map<String, dynamic> service) async{
    selectedServiceTypes = await ApiService.instance.fetchAllServiceTypes('services/${service['id']}/${service['name'].toString().toLowerCase()}');
    unitPrice = (selectedServiceTypes.singleWhere((element) => element['type'].toString().toLowerCase() == serviceType.toLowerCase()))['price'] * 1.0;
  }

  void clearRequestStatsCount(){
    requestStats.forEach((requestStat) {
      requestStat['count'] = 0;
    });
  }

  void populateCompletedAndPendingUserRequests(){
    clearRequestStatsCount();
    
    requests.forEach((element) {
      if(element['status'].toString().toLowerCase() == 'pending' || element['status'].toString().toLowerCase() == 'approved'){
        requestStats[0]['count'] += 1;
      }
      else if(element['status'].toString().toLowerCase() == 'completed'){
        requestStats[1]['count'] += 1;
      }
      else if(element['status'].toString().toLowerCase() == 'rejected'){
        requestStats[2]['count'] += 1;
      }
    });
    this.requestStats.refresh();
  }


  void populateCurrentMonthEarning(){
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int firstDayOfMonth = 1;
    var tempTotal = 0.0;

    requests.forEach((element) {
       var requestDate = DateTime.fromMillisecondsSinceEpoch(element['date']['_seconds'] * 1000);
       if(requestDate.isAfter(DateTime(currentYear, currentMonth, firstDayOfMonth)) && requestDate.isBefore(DateTime(currentYear, currentMonth + 1, firstDayOfMonth)) &&
           (element['status'] == 'approved' || element['status'] == 'completed')){
         tempTotal += element['amount_paid'];
       }
     });
    currentMonthEarning.value = tempTotal;
    populateWeeklyStats();

  }

  List<dynamic> getWeekDates(){
    int daysInWeek = 6;
    int weekDay = DateTime.now().weekday;
    int today = DateTime.now().day;
    int monthEnd = DateTime(2020, 11, 0).day;
    int weekStart = today - weekDay;
    int weekEnd = weekStart + daysInWeek >= monthEnd ? monthEnd : weekStart + daysInWeek;


    while(weekStart <= weekEnd){
      dailyRequestsStat.add({'date' : '$year-${month > 10 ? month : '0$month' }-${weekStart > 10 ? weekStart : '0$weekStart'}', 'pending' : 0,  'completed' : 0});
      weekStart += 1;
    }
    return dailyRequestsStat;
  }

  void populateWeeklyStats(){
    getWeekDates().forEach((weekDate) {
       requests.forEach((request) {
         var requestDate = DateTime.fromMillisecondsSinceEpoch(request['date']['_seconds'] * 1000).toString().substring(0, 10);
         if(weekDate['date'] == requestDate){
           switch(request['status'].toString().toLowerCase()){
             case 'pending':
             case 'approved':
               weekDate['pending']+=1;
               break;

             case 'completed':
               weekDate['completed']+=1;
               break;
           }
         }
       });
    });
    // print('====> $dailyRequestsStat');
    this.dailyRequestsStat.refresh();
  }

  void onServiceTypeSelectedCallback(BuildContext context, String serviceName){
    setRequestedServiceName(serviceName);
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestForm()));
  }

  void setChildName(String name){
    childName = name;
  }

  void setRequestedServiceName(String service){
    serviceName = service;
    selectedService =  services.singleWhere((element) => element['name'].toString().toLowerCase()  == service.toLowerCase());
    fetchSelectedServiceTypes(selectedService);

//    setUnitPrice(700);
  }

//  void setUnitPrice(double price){
//    unitPrice = price;
    // setTotalPrice();
//  }


  // void setTotalPrice(){
  //   totalPrice.value = unitPrice * serviceQuantity.value;
  // }

  void setRequestedServiceDate(int year, int month, int day){

    serviceDate = DateTime(year, month, day);
    setServiceDay(day);
  }

  // void setServiceQuantity(int quantity){
  //   serviceQuantity.value = quantity;
  //   setTotalPrice();
  // }

  void setServiceDay(int day){
    serviceDay.value = day;
  }

  // void onChangedChildNameTextField(String value){
  //   if(value == null || value.trim().isEmpty){
  //     childNameFieldError.value = 'Child\'s name is required!';
  //   }else{
  //     childName = value;
  //     childNameFieldError.value = '';
  //   }
  // }

  // void onChangedContactNumberTextField(String value){
  //   if(value == null || value.trim().isEmpty){
  //     contactNumberFieldError.value = 'Contact number is required!';
  //   }else{
  //     contactNo = value;
  //     contactNumberFieldError.value = '';
  //   }
  // }

  Future<String> getUserIdFromStorage() async{
    return await SecureStorage.instance.read(key: 'USER_ID');
  }

  void submitRequestForm(BuildContext context,  Map<String, dynamic> request, Function callback) async{
    String userId = await getUserIdFromStorage();
    // onChangedChildNameTextField(childName);
    // onChangedContactNumberTextField(contactNo);


    // if(receiptUrl.value == null ||  receiptUrl.value.isEmpty){
    //   receiptUploadFieldError.value = 'No receipt found!';
    // }

    // if(childNameFieldError.value.isEmpty && contactNumberFieldError.value.isEmpty && receiptUploadFieldError.value.isEmpty){
      try{
        File imageFile = File(request['receipt']);
        List<int> imageBytes = imageFile.readAsBytesSync();

        dynamic response = ApiService.instance.createNewRequest('users/$userId/requests', {
          'name' : request['name'],
          'contact' : request['contact'],
          'registeredContact': contactNo,
          'amount_paid' : request['total_price'],
          'quantity' : request['quantity'],
          'image' : base64Encode(imageBytes), //request['receipt'],
          'price' : unitPrice,
          'serviceName' : serviceName,
          'serviceType' : serviceType,
          'date' : serviceDate.toIso8601String()
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request created sucessfully')));
        callback();
        Future.delayed(Duration(seconds: 1), (){
          Navigator.of(context).pop();
          // Navigator.of(context).popUntil((route) => route.isFirst);
        });

      }catch(e){
        print('Cannot create request, Error: $e');
    // }
    }
  }

  // void pickReceiptImage() async{
  //   final PickedFile pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
  //   if(pickedImage.path.isNotEmpty){
  //     // receiptPath.value = pickedImage.path;
  //     // File receipt = File(pickedImage.path);
  //     // List<int> imageBytes = receipt.readAsBytesSync();
  //     // receiptUrl.value = base64Encode(imageBytes);
  //     receiptUrl.value = pickedImage.path;
  //     receiptUploadFieldError.value = '';
  //   }
  // }

  // void clearErrors(){
  //   receiptUploadFieldError.value = '';
  //   childName = '';
  //   contactNo= '';
  //   receiptUrl.value = '';
  //   contactNumberFieldError.value = '';
  //   childNameFieldError.value = '';
  //   receiptUploadFieldError.value = '';
  // }
}