//服务器地址
const String baseUrl ='';
//app设置的语言
const String lang = 'zh';
///图片地址扩展，主要用于国际化图片
extension IntlUrlStringExtension on String{
  /// 获取国际化的图片地址
  String getIntlUrlString() {
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
