import 'package:get/get.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/services/api_service.dart';

class CalendarController extends GetxController{
  RxList<dynamic> todaysRequests = [].obs;
  RxString selectedDate = DateTime.now().toString().substring(0, 10).obs;
  RxList<dynamic> requestDates = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllRequests();
  }

  Future<void> fetchAllRequests() async{
    dynamic response = await ApiService.instance.fetchAllRequests('requests');
    todaysRequests.assignAll(response);
  }

  List<dynamic> populateRequestDates(){
    todaysRequests.forEach((element) {
      requestDates.add(DateTime.fromMillisecondsSinceEpoch(element['date']['_seconds'] * 1000).toString().substring(0, 10));
    });
    return requestDates.toList();
  }

  void setTodaysRequests(){
    selectedDate.value = Get.find<DashboardController>().serviceDate.toString().substring(0, 10);
  }
}