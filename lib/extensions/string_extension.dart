extension StringExtension on String {
  /// 解决省略号异常问题
  String useCorrectEllipsis() {
    return replaceAll('', '\u200B');
  }
}
