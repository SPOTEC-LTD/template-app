// Author: Dean.Liu
// DateTime: 2021/08/24 10:40

import '../basic/router/f_router.dart';
import 'common/common_route_handler.dart';
import 'route_demo/route_demo_handler.dart';

extension FRouterSetup on FRouter {
  void configureRoutes() {
    CommonRoutesHandler.configureRouter();
    RouteDemoRoutesHandler.configureRouter();
  }
}
