import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/services/api_service.dart';

class RequestsController extends GetxController {
  final Query requestCollection = FirebaseFirestore.instance.collection('requests');
  // RxList<dynamic> requests = [].obs;
  // RxList<dynamic> userRequests = [].obs;
  RxBool hideCompleted = true.obs;
  // int completedRequests = 0;
  // int approvedRequests = 0;
  // int pendingRequests = 0;
  // final RxList<dynamic> requestStats = [
  //   {'title': 'Pending', 'icon': Icons.bar_chart, 'count': 0},
  //   {'title': 'Completed', 'icon': Icons.insert_chart_outlined, 'count': 0},
  //   {'title': 'Rejected', 'icon': Icons.error_outline, 'count': 0}
  // ].obs;

  @override
  void onInit() {
    super.onInit();
    // fetchAllRequests();
    // fetchAllUserRequests();
  }

  Stream<QuerySnapshot> get requests {
    return requestCollection.snapshots();
  }

  Stream<QuerySnapshot> get userRequests {
    return requestCollection.where('user.contact', isEqualTo: '7654321').snapshots();
  }

  // Future<void> fetchAllUserRequests() async{
  //   dynamic response  = await ApiService.instance.fetchAllRequests('requests/7654321');
  //   userRequests.assignAll(response);
  //   populateCompletedAndPendingUserRequests();
  // }

  // void populateCompletedAndPendingUserRequests(){
  //   userRequests.forEach((element) {
  //     if(element['status'].toString().toLowerCase() == 'pending' || element['status'].toString().toLowerCase() == 'approved'){
  //       requestStats[0]['count'] += 1;
  //     }
  //     else if(element['status'].toString().toLowerCase() == 'completed'){
  //       requestStats[1]['count'] += 1;
  //     }
  //     else if(element['status'].toString().toLowerCase() == 'rejected'){
  //       requestStats[2]['count'] += 1;
  //     }
  //   });
  //   this.requestStats.refresh();
  // }

  Future<void> updateRequestStatus(BuildContext context, String id, String status) async{
    try{
      dynamic response  = await ApiService.instance.updateRequest('requests/$id', {'status' : status});
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Status updated successfully'),));
    }catch(e){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('An error occurred, please try again'),));
    }
  }

  void toggleHideCompleted(){
    hideCompleted.value = !hideCompleted.value;
  }
}