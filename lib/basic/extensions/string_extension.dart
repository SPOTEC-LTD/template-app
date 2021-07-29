// 服务器地址
const String baseUrl = '';
// app设置的语言
const String lang = 'zh';

extension StringExtension on String {
  /// 解决省略号异常问题
  String useCorrectEllipsis() {
    return replaceAll('', '\u200B');
  }

  /// string 转 bool
  bool toBool() {
    return toLowerCase() == true.toString();
  }

  /// 获取国际化的url地址
  String get intlUrlString {
    if (isEmpty) {
      return this;
    }
    var queryParameters = Uri.parse(this).queryParameters;
    var linkSymbol = '&';
    if (queryParameters.isEmpty) {
      linkSymbol = '?';
    }
    // 首先是内部链接
    if (contains(baseUrl)) {
      // 其次没有国际化参数
      if (!contains('locale=')) {
        return this + '${linkSymbol}locale=$lang';
      }
    }
    return this;
  }
}
