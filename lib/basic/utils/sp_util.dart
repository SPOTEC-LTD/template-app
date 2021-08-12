import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../generated/json/base/json_convert_content.dart';

/// 用来做shared_preferences的存储
class SpUtil {
  static SharedPreferences? _spf;

  /// 配置util，为异步函数
  static Future<SharedPreferences?> setup() async {
    _spf = await SharedPreferences.getInstance();
    return _spf;
  }

  /// 获取存储的所有keys
  static Set<String>? getKeys() {
    return _spf?.getKeys();
  }

  /// 判断shared_preferences的keys是否包含[key]
  static bool containsKey(String key) {
    return _spf?.containsKey(key) ?? false;
  }

  /// 根据[key]获取字符串
  static String? getString(String key) {
    return _spf?.getString(key);
  }

  /// 根据[key]存储字符串[value]
  static Future<bool>? putString(String key, String value) {
    return _spf?.setString(key, value);
  }

  /// 根据[key]获取布尔值
  static bool? getBool(String key) {
    return _spf?.getBool(key);
  }

  /// 根据[key]存储布尔值[value]
  static Future<bool>? putBool(String key, bool value) {
    return _spf?.setBool(key, value);
  }

  /// 根据[key]获取整数
  static int? getInt(String key) {
    return _spf?.getInt(key);
  }

  /// 根据[key]存储整数[value]
  static Future<bool>? putInt(String key, int value) {
    return _spf?.setInt(key, value);
  }

  /// 根据[key]获取浮点数
  static double? getDouble(String key) {
    return _spf?.getDouble(key);
  }

  /// 根据[key]存储浮点数[value]
  static Future<bool>? putDouble(String key, double value) {
    return _spf?.setDouble(key, value);
  }

  /// 根据[key]获取字符串数组
  static List<String>? getStringList(String key) {
    return _spf?.getStringList(key);
  }

  /// 根据[key]存储字符串数组[value]
  static Future<bool>? putStringList(String key, List<String> value) {
    return _spf?.setStringList(key, value);
  }

  /// 根据[key]存储泛型对象[entity]
  static Future<bool>? putEntity<T>(String key, T entity) async {
    if (entity == null) {
      return remove(key) ?? Future.value(false);
    } else if (entity is JsonConvert) {
      final encodeString = json.encode(entity.toJson());
      return putString(key, encodeString) ?? Future.value(false);
    } else {
      return false;
    }
  }

  /// 根据[key]获取存储泛型对象
  static T? getEntity<T>(String key) {
    final string = getString(key);
    if (string == null) {
      return null;
    }
    return JsonConvert.fromJsonAsT<T>(json.decode(string));
  }

  /// 根据[key]删除存储对象
  static Future<bool>? remove(String key) {
    return _spf?.remove(key);
  }

  /// 清除所有shared_preferences的本地存储
  static Future<bool>? clear() {
    return _spf?.clear();
  }
}
