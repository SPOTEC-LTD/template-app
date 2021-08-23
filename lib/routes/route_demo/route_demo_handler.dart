// Author: Dean.Liu
// DateTime: 2021/08/23 10:44

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../basic/router/f_router.dart';
import '../../business/route_demo/nested_route_page.dart';
import 'f_router_route_demo.dart';

class RouteDemoRoutesHandler {
  static void configureRouter() {
    // final appRouter = FluroRouter.appRouter;
    _configureNestedRouteNavigator();
  }

  static void _configureNestedRouteNavigator() {
    final appRouter = FluroRouter.appRouter;
    final nestedRouteNavigatorHandler = Handler(handlerFunc: (context, params) {
      return Navigator(
        initialRoute: FRouter().nestedRoutePage,
        onGenerateInitialRoutes: (state, initialRouteName) {
          final initRoute = state.widget.onGenerateRoute?.call(RouteSettings(
            name: FRouter().nestedRoutePage,
            arguments: context?.settings?.arguments,
          ));
          return initRoute == null ? [] : [initRoute];
        },
        onGenerateRoute: FluroRouter.appRouter.generator,
      );
    });
    appRouter.define(FRouter().nestedRouteNavigatorPath,
        handler: nestedRouteNavigatorHandler);
    appRouter.define(FRouter().nestedRoutePage,
        handler: nestedRoutePageHandler);
  }
}

Handler nestedRoutePageHandler = Handler(handlerFunc: (context, _) {
  return const NestedRoutePage();
});
