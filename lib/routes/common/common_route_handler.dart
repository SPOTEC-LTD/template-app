import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../basic/router/f_router.dart';
import '../../basic/utils/type_util.dart';
import '../../basic/views/base/base_app_bar.dart';
import '../../business/common/views/web_view_page.dart';
import 'f_router_common.dart.dart';

class CommonRoutesHandler {
  static void configureRouter() {
    _configureNotFoundPage();
    final appRouter = FluroRouter.appRouter;
    appRouter.define(FRouter().webViewPage, handler: webViewPageHandler);
  }

  static void _configureNotFoundPage() {
    FluroRouter.appRouter.notFoundHandler = Handler(handlerFunc: (context, _) {
      return Scaffold(
        appBar: BaseAppBar(
          titleText: 'Not Found Page',
          brightness: Brightness.light,
        ),
        body: const Center(
          child: Text('Please Check'),
        ),
      );
    });
  }
}

Handler webViewPageHandler = Handler(handlerFunc: (context, _) {
  final params = TypeUtil.safeCast<Map>(context?.settings?.arguments) ?? {};
  return WebViewPage(
    type: WebViewPageType.values[params['typeIndex']],
    url: params['url'],
    richText: params['richText'],
    title: params['title'],
    showAppBar: params['showAppBar'],
    showShareButton: params['showShareButton'],
  );
});
