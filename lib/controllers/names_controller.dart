import 'package:get/get.dart';
import 'package:qurbani/services/api_service.dart';

class NamesController extends GetxController {
  RxList<dynamic> nameList = [].obs;
  // List<Map<String, dynamic>> tempList;

  @override
  void onInit() {
    super.onInit();
    fetchAllNames();
  }

  Future<void> fetchAllNames() async{
    dynamic response = await ApiService.instance.getAllNames('names');
    nameList.assignAll(response);
  }

  Future<void> toggleFavoriteName(int index) async {
    nameList[index]['is_favorite'] = !nameList[index]['is_favorite'];
    this.nameList.refresh();
    await ApiService.instance.updateName('names/${nameList[index]['id']}',
        {'is_favorite': nameList[index]['is_favorite']});
  }
}