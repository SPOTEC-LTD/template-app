import 'package:shared_preferences/shared_preferences.dart';

/// 用来做shared_preferences的存储
class SpUtil {
  static final SpUtil _spUtils = SpUtil._();
  factory SpUtil() => _spUtils;

  SpUtil._();

  SharedPreferences? _spf;

  // 初始化，必须要初始化
  Future<SharedPreferences?> setup() async {
    _spf = await SharedPreferences.getInstance();
    return _spf;
  }

  // 检查内部存储库是否初始化
  bool get _isSpfNull {
    return _spf == null;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set<String>? keys = getKeys();
    return keys!.contains(key);
  }

  Set<String>? getKeys() {
    if (_isSpfNull) return null;
    return _spf!.getKeys();
  }

  String? getString(String key) {
    if (_isSpfNull) return null;
    return _spf!.getString(key);
  }

  Future<bool>? putString(String key, String value) {
    if (_isSpfNull) return null;
    return _spf!.setString(key, value);
  }

  bool? getBool(String key) {
    if (_isSpfNull) return null;
    return _spf!.getBool(key);
  }

  Future<bool>? putBool(String key, bool value) {
    if (_isSpfNull) return null;
    return _spf!.setBool(key, value);
  }

  int? getInt(String key) {
    if (_isSpfNull) return null;
    return _spf!.getInt(key);
  }

  Future<bool>? putInt(String key, int value) {
    if (_isSpfNull) return null;
    return _spf!.setInt(key, value);
  }

  double? getDouble(String key) {
    if (_isSpfNull) return null;
    return _spf!.getDouble(key);
  }

  Future<bool>? putDouble(String key, double value) {
    if (_isSpfNull) return null;
    return _spf!.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    if (_isSpfNull) return null;
    return _spf!.getStringList(key);
  }

  Future<bool>? putStringList(String key, List<String> value) {
    if (_isSpfNull) return null;

    return _spf!.setStringList(key, value);
  }

  // // 保存范型模型
  // Future<bool>? putBean<T>(T bean, String key) async {
  //   if (bean == null) {
  //     return this!.putString(key, null);
  //   } else if (bean is JsonConvert) {
  //     var editedJonStr = json.encode(bean.toJson());
  //     return SpUtil().putString(key, editedJonStr);
  //   } else {
  //     return false;
  //   }
  // }

  // // 获取范型模型
  // T? getBean<T>(String key) {
  //   if (SpUtil().getString(key) == null) {
  //     return null;
  //   }
  //   return JsonConvert.fromJsonAsT<T>(json.decode(SpUtil().getString(key)));
  // }

  dynamic getDynamic(String key) {
    if (_isSpfNull) return null;
    return _spf!.get(key);
  }

  Future<bool> remove(String key) {
    return _spf!.remove(key);
  }

  Future<bool> clear() {
    return _spf!.clear();
  }

  ///sp储存合集 保存数据 基础类型
  ///
  ///@param key   key
  ///@param param param
  Future<dynamic>? saveParam(String key, dynamic param) {
    if (_isSpfNull) return null;
    if (param is String) {
      return _spf!.setString(key, param);
    } else if (param is int) {
      return _spf!.setInt(key, param);
    } else if (param is bool) {
      return _spf!.setBool(key, param);
    } else if (param is double) {
      return _spf!.setDouble(key, param);
    } else {
      throw UnsupportedError('Unknown Type');
    }
  }

  ///sp储存合集 获取数据 基础类型
  ///
  ///@param key   key
  ///@param param defaultParam
  dynamic getParam(String key, Object defaultParam) {
    if (_isSpfNull) return null;
    if (defaultParam is String) {
      return _spf!.getString(key);
    } else if (defaultParam is int) {
      return _spf!.getInt(key);
    } else if (defaultParam is bool) {
      return _spf!.getBool(key);
    } else if (defaultParam is double) {
      return _spf!.getDouble(key);
    } else {
      throw UnsupportedError('Unknown Type');
    }
  }
}
