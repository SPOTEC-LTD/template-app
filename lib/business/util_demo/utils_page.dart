import 'package:flutter/material.dart';
import 'package:template/basic/views/base/base_app_bar.dart';
import 'package:template/common/views/title_action_item.dart';
import 'package:template/business/util_demo/hud_page.dart';
import 'package:template/business/util_demo/toast_page.dart';

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
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const HudPage();
      }),
    );
  }

  void _pushToastPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const ToastPage();
      }),
    );
  }
}
