import 'package:template/routes/common/common_route_handler.dart';

import 'f_router.dart';

extension FRouterSetup on FRouter {
  void setup() {
    CommonRoutesHandler.configureRouter();
  }
}
