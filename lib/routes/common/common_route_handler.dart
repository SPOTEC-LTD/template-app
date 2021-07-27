import 'package:fluro/fluro.dart';
import 'package:template/module/common/views/web_view_page.dart';

import 'common_routes.dart';

class CommonRoutesHandler {
  static void configureRouter() {
    var appRouter = FluroRouter.appRouter;
    appRouter.define(CommonRoutes.webViewPage, handler: webViewPageHandler);
  }
}

var webViewPageHandler = Handler(handlerFunc: (context, params) {
  // var model = context?.settings?.arguments as WebViewPageParam;
  return WebViewPage(
    type: WebViewPageType.richText,
    // url: 'https://www.baidu.com/',
    richText: 'adad',
    // type: WebViewPageType.values[model.typeIndex],
    // url: model.url,
    // richText: model.richText,
    // title: model.title,
    // showAppBar: model.showAppBar,
    // showShareButton: model.showShareButton,
  );
});
