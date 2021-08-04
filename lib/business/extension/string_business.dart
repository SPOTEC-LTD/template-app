import 'package:template/business/consts/service_urls.dart';

const String lang = '';

extension StringBusiness on String {
  /// 判断远程路由是否可以打开本地页面
  bool get isInnerUrl {
    return startsWith(innerUrl);
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
    if (contains(baseWebURL)) {
      // 其次没有国际化参数
      if (!contains('locale=')) {
        return this + '${linkSymbol}locale=$lang';
      }
    }
    return this;
  }
}
