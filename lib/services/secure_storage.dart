import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage extends FlutterSecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();

  static SecureStorage instance = SecureStorage();

  factory SecureStorage(){
    return _instance;
  }

  SecureStorage._internal();
}

