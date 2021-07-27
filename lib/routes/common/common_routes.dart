import 'package:flutter/material.dart';
import 'package:template/generated/json/base/json_convert_content.dart';
import 'package:template/routes/f_router.dart';

class CommonRoutes {
  static String webViewPage = '/webView/webViewPage';
}

extension FRouterCommonExtension on FRouter {
  Widget webViewPage(BuildContext context) {
    return FRouter().matchPage(context, CommonRoutes.webViewPage);
  }
}

class WebViewPageParam with JsonConvert<WebViewPageParam> {
  // 0-富文本 1-url
  int typeIndex;
  String? url;
  String? richText;
  String? title;
  bool showAppBar;
  bool showShareButton;

  WebViewPageParam({
    required this.typeIndex,
    this.url,
    this.richText,
    this.title,
    this.showAppBar = true,
    this.showShareButton = false,
  });
}
