// Author: Dean.Liu
// DateTime: 2021/08/23 10:49

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../basic/router/f_router.dart';
import '../../basic/views/base/base_app_bar.dart';
import '../../common/views/title_action_item.dart';
import 'route_home_page.dart';

class NestedRouteHomePage extends StatelessWidget {
  const NestedRouteHomePage({Key? key}) : super(key: key);

  void _pushRouteDemoPage(BuildContext context) {
    FRouter().pushPage(context, const RouteHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'NestedRoutePage',
        actions: [
          CupertinoButton(
            child: const Text('Close'),
            onPressed: () {
              FRouter();
            },
          )
        ],
      ),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Push Route Home',
            onTap: () => _pushRouteDemoPage(context),
          ),
        ],
      ),
    );
  }
}
