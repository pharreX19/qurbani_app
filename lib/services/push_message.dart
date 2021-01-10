import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:qurbani/main.dart';

class PushMessage{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  void initialize(){
   if(!_initialized){
     _firebaseMessaging.configure(
       onMessage: (Map<String, dynamic> message) async {
         print("onMessage: $message");
         // _showItemDialog(message);
       },
       onBackgroundMessage: backgroundMessageHandler,
       onLaunch: (Map<String, dynamic> message) async {
         print("onLaunch: $message");
         // _navigateToItemDetail(message);
       },
       onResume: (Map<String, dynamic> message) async {
         print("onResume: $message");
         // _navigateToItemDetail(message);
       },
     );
   }
   _initialized = true;
  }

  Future<String> getToken() async {
    initialize();
    return await _firebaseMessaging.getToken();
  }
}