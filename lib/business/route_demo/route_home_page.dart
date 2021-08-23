// Author: Dean.Liu
// DateTime: 2021/08/23 10:33

import 'package:flutter/material.dart';

import '../../basic/router/f_router.dart';
import '../../basic/views/base/base_app_bar.dart';
import '../../common/views/title_action_item.dart';
import '../../routes/route_demo/f_router_route_demo.dart';

class RouteHomePage extends StatelessWidget {
  const RouteHomePage({Key? key}) : super(key: key);

  void _presentNestedNavigator(BuildContext context) {
    FRouter().present(context, FRouter().nestedRouteNavigatorPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'Route Demo'),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Present',
            onTap: () => _presentNestedNavigator(context),
          ),
        ],
      ),
    );
  }
}
