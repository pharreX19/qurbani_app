import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{
  final Query notificationCollection = FirebaseFirestore.instance.collection('notifications');
  final String deviceToken = 'dY-_8ifoRzWAJZIMD5xr91:APA91bGAD7XBDc0uqURZCH-7Q73mS9ZrHjvw5i7ms-Cum7qRHwiQ8mduSNihflPu2qltBo3oVQiY_Rw2glEvT6HRHZSdl4Wnw5HYFeAR8XaozQvxz1nULt2sSHnHtLrawjPbG2XpS-2a';

  Stream<QuerySnapshot> notifications(){
    return notificationCollection.where('device_token', isEqualTo: deviceToken).snapshots();
  }
}