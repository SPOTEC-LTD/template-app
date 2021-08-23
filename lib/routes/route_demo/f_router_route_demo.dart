// Author: Dean.Liu
// DateTime: 2021/08/24 10:40

import '../../basic/router/f_router.dart';

extension FRouterRouteDemoExtension on FRouter {
  String get _nestedRoute => 'nestedRoute';
  String get nestedRouteNavigatorPath => '/$_nestedRoute';
  String get nestedRoutePage => '$_nestedRoute/nestedRoutePage';
}
