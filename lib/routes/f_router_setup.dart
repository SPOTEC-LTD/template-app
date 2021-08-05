import 'package:template/routes/common/common_route_handler.dart';

import '../basic/router/f_router.dart';

extension FRouterSetup on FRouter {
  void configureRoutes() {
    CommonRoutesHandler.configureRouter();
  }
}
