import 'package:flutter/material.dart';
import 'package:template/basic/utils/intl_util.dart';
import 'package:template/common/consts/service_urls.dart';

extension StringBusiness on String? {
  /// 获取国际化的url地址
  String getIntlUrlString(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return '';
    }
    var queryParameters = Uri.parse(this!).queryParameters;
    var linkSymbol = '&';
    if (queryParameters.isEmpty) {
      linkSymbol = '?';
    }
    // 首先是内部链接
    if (this!.contains(baseWebURL)) {
      // 其次没有国际化参数
      if (!this!.contains('locale=')) {
        final lang = IntlUtil.getFullLocaleCode(context);
        return this! + '${linkSymbol}locale=$lang';
      }
    }
    return this!;
  }
}
