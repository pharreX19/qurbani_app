import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class InformationController extends GetxController{
  final Query informationCollection = FirebaseFirestore.instance.collection('information');


  Stream<QuerySnapshot> get information{
    return informationCollection.snapshots();

  }
}