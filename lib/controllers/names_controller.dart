import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qurbani/services/api_service.dart';

class NamesController extends GetxController {
  final Query nameCollection = FirebaseFirestore.instance.collection('names');
  RxList<dynamic> nameList = [].obs;
  // List<Map<String, dynamic>> tempList;

//  @override
//  void onInit() {
//    super.onInit();
//    fetchAllNames();
//  }

  Stream<QuerySnapshot> get names{
    return nameCollection.snapshots();
//    dynamic response = await ApiService.instance.getAllNames('names');
//    nameList.assignAll(response);
  }

  Future<void> toggleFavoriteName(String id, bool isFavorite) async {
//    nameList[index]['is_favorite'] = !nameList[index]['is_favorite'];
//    this.nameList.refresh();
    await ApiService.instance.updateName('names/$id',
        {'is_favorite': isFavorite});
  }
}