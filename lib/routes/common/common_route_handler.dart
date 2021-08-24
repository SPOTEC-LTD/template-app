import 'package:fluro/fluro.dart';

import '../../basic/extensions/string_extension.dart';
import '../../basic/router/f_router.dart';
import '../../business/common/views/path_not_found_page.dart';
import '../../business/common/views/route_param_null_page.dart';
import '../../business/common/views/web_view_page.dart';
import 'f_router_common.dart.dart';

class CommonRoutesHandler {
  static void configureRouter() {
    final appRouter = FluroRouter.appRouter;
    appRouter.define(FRouter().webViewPage, handler: webViewPageHandler);
    _configureExceptionPage();
  }

  static void _configureExceptionPage() {
    final appRouter = FluroRouter.appRouter;
    appRouter.notFoundHandler = Handler(handlerFunc: (context, _) {
      return const PathNotFoundPage();
    });
    appRouter.define(FRouter().routeParamNullPage,
        handler: routeParamNullPageHandler);
  }
}

Handler routeParamNullPageHandler = Handler(handlerFunc: (context, _) {
  return const RouteParamNullPage();
});

Handler webViewPageHandler = Handler(handlerFunc: (context, _) {
  final params = context?.settings?.arguments as Map<String, String>?;
  if (params == null || params.isEmpty) {
    return const RouteParamNullPage();
  }
  return WebViewPage(
    type: WebViewPageType.values[params['typeIndex'].toInt()],
    url: params['url'],
    richText: params['richText'],
    title: params['title'],
    showAppBar: params['showAppBar'].toBool(),
    showShareButton: params['showShareButton'].toBool(),
  );
});
