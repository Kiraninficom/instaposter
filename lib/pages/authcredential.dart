import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authcredential {
  final storage = const FlutterSecureStorage();
  //save usercredential when login
  void storeToken(String value) async {
    if (kDebugMode) {
      //print("storing token and data");
    }
    await storage.write(key: "token", value: value);
  }

  Future<String?> getToken() {
    return storage.read(key: "token");
  }

  void storeindex(String value) async {
    if (kDebugMode) {
      //print("storing token and data");
    }
    await storage.write(key: "subsc", value: value);
  }

  Future<String?> getindex() {
    return storage.read(key: "subsc");
  }

  Future<void> deleteToken() async {
    return await storage.delete(key: "token");
  }

  savevaluetolocal(String key, String data) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, data);
  }

  getfromlocal(String key) async {
    final pref = await SharedPreferences.getInstance();
    var data = pref.getString(key);
    return data;
  }
}
