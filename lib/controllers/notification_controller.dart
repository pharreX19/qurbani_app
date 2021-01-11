import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{
  final Query notificationCollection = FirebaseFirestore.instance.collection('notifications');

  Stream<QuerySnapshot> notifications(){
    return notificationCollection.snapshots();
  }
}