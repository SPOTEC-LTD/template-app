// Author: Dean.Liu
// DateTime: 2021/08/23 10:44

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../basic/router/f_router.dart';
import '../../business/route_demo/nested_route_home_page.dart';
import 'f_router_route_demo.dart';

class RouteDemoRoutesHandler {
  static void configureRouter() {
    _configureNestedRouteNavigator();
  }

  static void _configureNestedRouteNavigator() {
    final appRouter = FluroRouter.appRouter;
    final navigatorKey = GlobalKey();
    final nestedRouteNavigatorHandler = Handler(handlerFunc: (context, params) {
      return WillPopScope(
        onWillPop: () => FRouter().androidHardwarePop(key: navigatorKey),
        child: Navigator(
          key: navigatorKey,
          initialRoute: FRouter().nestedRouteHomePage,
          onGenerateInitialRoutes: (state, initialRouteName) {
            final initRoute = state.widget.onGenerateRoute?.call(RouteSettings(
              name: FRouter().nestedRouteHomePage,
              arguments: context?.settings?.arguments,
            ));
            return initRoute == null ? [] : [initRoute];
          },
          onGenerateRoute: appRouter.generator,
        ),
      );
    });
    appRouter.define(FRouter().nestedRouteNavigatorPath,
        handler: nestedRouteNavigatorHandler);
    appRouter.define(FRouter().nestedRouteHomePage,
        handler: nestedRoutePageHandler);
  }
}

Handler nestedRoutePageHandler = Handler(handlerFunc: (context, _) {
  return const NestedRouteHomePage();
});
