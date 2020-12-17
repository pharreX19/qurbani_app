import 'package:get/get.dart';

class HomeController extends GetxController{
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void setCurrentIndex(int index){
      currentIndex.value = index;
  }

}