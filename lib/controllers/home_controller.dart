import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:qurbani/controllers/homeController.dart';
import 'package:qurbani/services/api_service.dart';
import 'package:qurbani/services/local_notification.dart';
import 'package:qurbani/services/push_message.dart';
import 'package:qurbani/services/secure_storage.dart';

class HomeController extends GetxController{
  final PushMessage _pushMessage = PushMessage();
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    print('INITIALIZING HOME CONTROLLER');
    super.onInit();
    _pushMessage.getToken().then((token) => setFirebaseTokenInLocalStorage(token));
    LocalNotification.instance.initialize();
  }

  void setCurrentIndex(int index){
    currentIndex.value = index;
  }
  
  void setFirebaseTokenInLocalStorage(String token){
    print('SUE ROTKEN IS $token');
    SecureStorage.instance.write(key: "FB_TOKEN", value: token);
    // ApiService.instance.updateUser('users/k9JyOIaImGZodviv8n41', {'device_token' : token});
  }
}