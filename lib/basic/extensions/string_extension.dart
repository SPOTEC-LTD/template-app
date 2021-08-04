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
