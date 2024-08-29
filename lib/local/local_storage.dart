import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// SharedPreferences 本地存储
class LocalStorage {
  static Future<void> save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(key, value);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving to SharedPreferences: $e');
      }
    }
  }

  static Future<dynamic> get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.get(key);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading from SharedPreferences: $e');
      }
      return null;
    }
  }

  static Future<void> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove(key);
    } catch (e) {
      print('Error removing from SharedPreferences: $e');
    }
  }

  static Future<void> secureSave(String key, String value) async {
    const storage = FlutterSecureStorage();
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving to FlutterSecureStorage: $e');
      }
    }
  }

  static Future<String?> secureGet(String key) async {
    const storage = FlutterSecureStorage();
    try {
      String? value = await storage.read(key: key);
      return value;
    } catch (e) {
      if (kDebugMode) {
        print('Error reading from FlutterSecureStorage: $e');
      }
      return null;
    }
  }

  static Future<void> secureRemove(String key) async {
    const storage = FlutterSecureStorage();
    try {
      bool containsKey = await storage.containsKey(key: key);
      if (containsKey) {
        await storage.delete(key: key);
        if (kDebugMode) {
          print('Key "$key" deleted successfully.');
        }
      } else {
        if (kDebugMode) {
          print('Key "$key" does not exist.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting from FlutterSecureStorage: $e');
      }
    }
  }
}
