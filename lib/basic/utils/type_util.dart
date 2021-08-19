// Author: Dean.Liu
// DateTime: 2021/08/12 19:45

/// 类型转换工具类
class TypeUtil {
  /// 将当前类型转换为指定类型，如果无法转换，则返回 null
  static T? safeCast<T>(dynamic value) {
    if (value is T) {
      return value;
    }
    return null;
  }
}
