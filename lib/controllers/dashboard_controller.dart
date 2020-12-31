import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurbani/controllers/requests_controller.dart';
import 'package:qurbani/screens/dashboard/user/calendar_bottomsheet.dart';
import 'package:qurbani/screens/request/request_form.dart';
import 'package:qurbani/services/api_service.dart';

class DashboardController extends GetxController{
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  String serviceType;
  DateTime serviceDate;
  String childName;
  String contactNo;
  RxInt serviceQuantity = 1.obs;
  RxString receiptUrl =''.obs;
  RxDouble totalPrice = 0.0.obs;
  double unitPrice;
  RxInt serviceDay = DateTime.now().day.obs;
  RxString childNameFieldError = ''.obs;
  RxString contactNumberFieldError = ''.obs;
  RxString receiptUploadFieldError = ''.obs;
  RxDouble currentMonthEarning = 0.0.obs;
  final imagePicker = ImagePicker();
  RxList<dynamic>dailyRequestsStat = [].obs;

//  @override
//  void onInit() {
//    super.onInit();
//    final RequestsController requestsController = Get.put(RequestsController());
//    fetchAllRequests();
//  }

  Future<void> fetchAllRequests() async{
    // await Get.find<RequestsController>().fetchAllRequests();
    populateCurrentMonthEarning();
  }

  void populateCurrentMonthEarning(){
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int firstDayOfMonth = 1;
    var tempTotal = 0.0;
    // Get.find<RequestsController>().requests.forEach((element) {
    //   var requestDate = DateTime.fromMillisecondsSinceEpoch(element['date']['_seconds'] * 1000);
    //   if(requestDate.isAfter(DateTime(currentYear, currentMonth, firstDayOfMonth)) && (element['status'] == 'approved' || element['status'] == 'completed')){
    //     tempTotal += element['amount_paid'];
    //   }
    // });
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
      dailyRequestsStat.add({'date' : '$year-$month-$weekStart', 'pending' : 0,  'completed' : 0});
      weekStart += 1;
    }
    return dailyRequestsStat;
  }

  void populateWeeklyStats(){
    getWeekDates().forEach((weekDate) {
      // Get.find<RequestsController>().requests.forEach((request) {
      //   var requestDate = DateTime.fromMillisecondsSinceEpoch(request['date']['_seconds'] * 1000).toString().substring(0, 10);
      //   if(weekDate['date'] == requestDate){
      //     switch(request['status'].toString().toLowerCase()){
      //       case 'pending':
      //       case 'approved':
      //         weekDate['pending']+=1;
      //         break;
      //
      //       case 'completed':
      //         weekDate['completed']+=1;
      //         break;
      //     }
      //   }
      // });
    });
    this.dailyRequestsStat.refresh();
  }

  void onServiceTypeSelectedCallback(BuildContext context, String serviceName){
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestForm()));
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
    totalPrice.value = unitPrice * serviceQuantity.value;
  }

  void setRequestedServiceDate(int year, int month, int day){

    serviceDate = DateTime(year, month, day);
    setServiceDay(day);
  }

  void setServiceQuantity(int quantity){
    serviceQuantity.value = quantity;
    setTotalPrice();
  }

  void setServiceDay(int day){
    serviceDay.value = day;
  }

  void onChangedChildNameTextField(String value){
    if(value == null || value.trim().isEmpty){
      childNameFieldError.value = 'Child\'s name is required!';
    }else{
      childName = value;
      childNameFieldError.value = '';
    }
  }

  void onChangedContactNumberTextField(String value){
    if(value == null || value.trim().isEmpty){
      contactNumberFieldError.value = 'Contact number is required!';
    }else{
      contactNo = value;
      contactNumberFieldError.value = '';
    }
  }

  void submitRequestForm(){
    onChangedChildNameTextField(childName);
    onChangedContactNumberTextField(contactNo);


    if(receiptUrl.value == null ||  receiptUrl.value.isEmpty){
      receiptUploadFieldError.value = 'No receipt found!';
    }

    if(childNameFieldError.value.isEmpty && contactNumberFieldError.value.isEmpty && receiptUploadFieldError.value.isEmpty){
      try{
        ApiService.instance.createNewRequest('users/k9JyOIaImGZodviv8n41/requests', {
          'amount_paid' : totalPrice.value.toString(),
          'quantity' : serviceQuantity.value.toString(),
          'receipt' : receiptUrl.value,
          'name' : childName,
          'price' : unitPrice.toString(),
          'type' : serviceType,
          'date' : serviceDate.toIso8601String()
        });
      }catch(e){
        print('Cannot create request, Error: $e');
    }
    }
  }

  void pickReceiptImage() async{
    final PickedFile pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    if(pickedImage.path.isNotEmpty){
      // receiptPath.value = pickedImage.path;
      // File receipt = File(pickedImage.path);
      // List<int> imageBytes = receipt.readAsBytesSync();
      // receiptUrl.value = base64Encode(imageBytes);
      receiptUrl.value = pickedImage.path;
      receiptUploadFieldError.value = '';
    }
  }

  void clearErrors(){
    receiptUploadFieldError.value = '';
    childName = '';
    contactNo= '';
    receiptUrl.value = '';
    contactNumberFieldError.value = '';
    childNameFieldError.value = '';
    receiptUploadFieldError.value = '';
  }
}