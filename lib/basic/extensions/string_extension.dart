// Author: Dean.Liu
// DateTime: 2021/08/12 18:45

/// 字符串的通用扩展
extension StringExtension on String? {
  /// 解决省略号异常问题
  String? useCorrectEllipsis() {
    return this?.replaceAll('', '\u200B');
  }

  /// String 转 int
  int toInt() {
    if (this == null) {
      return 0;
    } else {
      return int.tryParse(this!) ?? 0;
    }
  }

  /// String 转 bool
  bool toBool() {
    if (this == null) {
      return false;
    } else {
      return this?.toLowerCase() == true.toString();
    }
  }
}
