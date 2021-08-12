import '../basic/router/f_router.dart';
import 'common/common_route_handler.dart';

extension FRouterSetup on FRouter {
  void configureRoutes() {
    CommonRoutesHandler.configureRouter();
  }
}
