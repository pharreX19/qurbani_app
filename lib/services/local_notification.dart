import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification{
  static final LocalNotification _instance = LocalNotification._internal();

  static LocalNotification instance = LocalNotification();

  factory LocalNotification(){
    return _instance;
  }

  LocalNotification._internal();


  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings _androidInitializationSettings = AndroidInitializationSettings('logo');
  static const  IOSInitializationSettings _iosInitializationSettings = IOSInitializationSettings();
  final InitializationSettings _initializationSettings = InitializationSettings(
    android: _androidInitializationSettings,
    iOS: _iosInitializationSettings
  );
  bool _initialized = false;

  void initialize() async{
    if(!_initialized){
      print('INITIALIZING LOCAL NOTIFICATION');
      await _flutterLocalNotificationsPlugin.initialize(_initializationSettings, onSelectNotification: selectNotification);
    }
    _initialized = true;
  }

  Future<dynamic> selectNotification(String message){
    print(message);
    return Future.value(null);
  }

  void showNotification() async{
    print('SHOWING NOTIFCICATION');
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'qurbani_app_id', 'qurbani-app', 'Qurbani App Notification Channel',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
    );
    await _flutterLocalNotificationsPlugin.show(0, 'Message title', 'Message body', platformChannelSpecifics, payload: 'Item X');
  }
}