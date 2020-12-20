import 'package:get/get.dart';

class CalendarController extends GetxController{
  RxList<dynamic> todaysRequests = [].obs;

  void setTodaysRequests(){
    todaysRequests.assignAll([
      {'name':'Aqeeqah', 'type':'Goat', 'quantity' : 2, 'child_name': 'Ahmed Ali'},
      {'name':'Udhiya', 'type':'Camel', 'quantity' : 1},
      {'name':'Aqeeqah', 'type':'Goat', 'quantity' : 2, 'child_name': 'Ahmed Ali'},
      {'name':'Udhiya', 'type':'Camel', 'quantity' : 1},
      {'name':'Aqeeqah', 'type':'Goat', 'quantity' : 2, 'child_name': 'Ahmed Ali'},
      {'name':'Udhiya', 'type':'Camel', 'quantity' : 1},
    ]);
  }
}