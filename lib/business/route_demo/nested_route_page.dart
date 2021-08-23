// Author: Dean.Liu
// DateTime: 2021/08/23 10:49

import 'package:flutter/material.dart';

import '../../basic/views/base/base_app_bar.dart';
import '../../common/views/title_action_item.dart';
import 'route_home_page.dart';

class NestedRoutePage extends StatelessWidget {
  const NestedRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'NestedRoutePage'),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Push Route Home',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const RouteHomePage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
