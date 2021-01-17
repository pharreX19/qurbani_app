import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qurbani/services/api_service.dart';
import 'package:qurbani/services/local_storage.dart';

class NamesController extends GetxController {
  final Query nameCollection = FirebaseFirestore.instance.collection('names');
  RxList<dynamic> nameList = [].obs;
  RxList<String> favoriteNames = RxList<String>([]);
  // List<Map<String, dynamic>> tempList;

 @override
 void onInit() {
   super.onInit();
//    fetchAllNames();
    getFavoriteNamesFromStorage();
 }

 void getFavoriteNamesFromStorage() async{
    favoriteNames?.addAll(LocalStorage.getStringList('FAVORITE_NAME'));
 }

  Stream<QuerySnapshot> get names{
    return nameCollection.snapshots();
//    dynamic response = await ApiService.instance.getAllNames('names');
//    nameList.assignAll(response);
  }

  Future<void> toggleFavoriteName(String id, bool isFavorite) async {
//    nameList[index]['is_favorite'] = !nameList[index]['is_favorite'];
//    this.nameList.refresh();
//     await ApiService.instance.updateName('names/$id',
//         {'is_favorite': isFavorite});
  if(isFavorite){
    print(isFavorite);
    favoriteNames.add(id);
  }else{
    favoriteNames.removeWhere((element) => element == id);
  }
  LocalStorage.setStringList('FAVORITE_NAME', favoriteNames.toList());
  // print('DONE');
  // print(favoriteNames);
  }
}