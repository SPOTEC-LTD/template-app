import 'package:flutter/material.dart';

import '../../basic/router/f_router.dart';
import '../../basic/views/base/base_app_bar.dart';
import '../../common/views/title_action_item.dart';
import 'hud_page.dart';
import 'toast_page.dart';

class UtilsPage extends StatelessWidget {
  const UtilsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Utils Demo',
      ),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Hud Demo',
            onTap: () => _pushHudPage(context),
          ),
          TitleActionItem(
            title: 'Toast Demo',
            onTap: () => _pushToastPage(context),
          ),
        ],
      ),
    );
  }

  void _pushHudPage(BuildContext context) {
    FRouter().pushPage(context, const HudPage());
  }

  void _pushToastPage(BuildContext context) {
    FRouter().pushPage(context, const ToastPage());
  }
}
