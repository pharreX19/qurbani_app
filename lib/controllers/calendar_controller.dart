import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:qurbani/services/api_service.dart';

class CalendarController extends GetxController{
  final Query requestCollection = FirebaseFirestore.instance.collection('requests');
  RxList<dynamic> todaysRequests = [].obs;
  RxString selectedDate = DateTime.now().toString().substring(0, 10).obs;

  @override
  void onInit() {
    super.onInit();
    // fetchAllRequests();
  }

  Stream<QuerySnapshot> get requests{
    return requestCollection.snapshots();
  }

  // Future<void> fetchAllRequests() async{
  //   dynamic response = await ApiService.instance.fetchAllRequests('requests');
  //   todaysRequests.assignAll(response);
  // }

  List<dynamic> populateRequestDates(List<DocumentSnapshot> requests){
    List<dynamic> requestDates = [];

    requests.forEach((element) {
      requestDates.add(DateTime.fromMillisecondsSinceEpoch(element['date'].seconds * 1000).toString().substring(0, 10));
    });
    print(requestDates);
    return requestDates.toList();
  }

  void setTodaysRequests(){
    selectedDate.value = Get.find<DashboardController>().serviceDate.toString().substring(0, 10);
  }
}