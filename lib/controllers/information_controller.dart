import 'package:get/get.dart';
import 'package:qurbani/services/api_service.dart';

class InformationController extends GetxController{
  RxList<dynamic> information = [].obs;

@override
  void onInit() {
    super.onInit();
    fetchAllInformation();
  }

  Future<void> fetchAllInformation() async{
    dynamic response = await ApiService.instance.fetchAllInformation('information');
    information.assignAll(response);
  }
}