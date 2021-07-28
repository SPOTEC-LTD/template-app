import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:template/module/common/views/web_view_page.dart';
import 'package:template/widgets/base/base_app_bar.dart';

class CommonRoutesHandler {
  static void configureRouter() {
    _configureNotFoundPage();
    var appRouter = FluroRouter.appRouter;
    appRouter.define('/webView/webViewPage', handler: webViewPageHandler);
  }

  static void _configureNotFoundPage() {
    FluroRouter.appRouter.notFoundHandler = Handler(handlerFunc: (context, _) {
      return Scaffold(
        appBar: BaseAppBar(
          titleText: 'Not Found Page',
        ),
        body: Center(
          child: Text('Please Check'),
        ),
      );
    });
  }
}

var webViewPageHandler = Handler(handlerFunc: (context, _) {
  var params = context?.settings?.arguments as Map;
  return WebViewPage(
    type: WebViewPageType.values[params['typeIndex']],
    url: params['url'],
    richText: params['richText'],
    title: params['title'],
    showAppBar: params['showAppBar'],
    showShareButton: params['showShareButton'],
  );
});
