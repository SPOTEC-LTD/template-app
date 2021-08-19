// Author: Dean.Liu
// DateTime: 2021/08/12 18:45

/// 字符串的通用扩展
extension StringExtension on String? {
  /// 解决省略号异常问题
  String? useCorrectEllipsis() {
    return this?.replaceAll('', '\u200B');
  }

  /// string 转 bool
  bool toBool() {
    if (this == null) {
      return false;
    } else {
      return this?.toLowerCase() == true.toString();
    }
  }
}
