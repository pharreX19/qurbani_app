import 'package:get/get.dart';

class NamesController extends GetxController {
  RxList<dynamic> nameList = [].obs;
  List<Map<String, dynamic>> tempList;

  @override
  void onInit() {
    super.onInit();
    tempList = List.generate(5, (index){
      return {
        'name' : 'Test Name $index',
        'meaning': 'Test Meaning Test Meaning Test Meaning Test Meaning Test Meaning Test Meaning Test Meaning Test Meaning Test Meaning Test Meaning Test Meaning Test Meaning ' ,
        'gender' : index % 2 == 0 ? 'male' : 'female',
        'is_favorited': false
      };
    });
    nameList.assignAll([...tempList]);
  }

  void toggleFavoriteName(int index){
    print('YAYY');
    tempList.forEach((element){
      if(element == nameList[index]){
        element['is_favorited'] = !element['is_favorited'];
      }
    });
    nameList.assignAll([...tempList]);
  }
}