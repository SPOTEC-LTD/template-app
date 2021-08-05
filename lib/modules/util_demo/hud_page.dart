import 'package:flutter/material.dart';
import 'package:template/basic/utils/hud_util.dart';
import 'package:template/basic/views/base/base_app_bar.dart';
import 'package:template/business/views/title_action_item.dart';

class HudPage extends StatelessWidget {
  const HudPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'HudUtil Demo'),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Show',
            onTap: () {
              HudUtil.show();
              Future.delayed(const Duration(seconds: 2), () {
                HudUtil.dismiss();
              });
            },
          ),
          TitleActionItem(
            title: 'Show And Callback',
            onTap: () {
              HudUtil.show();
              Future.delayed(const Duration(seconds: 2), () {
                HudUtil.dismiss();
              });
            },
          ),
          TitleActionItem(
            title: 'Show Success',
            onTap: () {
              HudUtil.showSuccess('Success Message');
            },
          ),
          TitleActionItem(
            title: 'Show Error',
            onTap: () {
              HudUtil.showError('Error Message');
            },
          ),
          TitleActionItem(
            title: 'Show Info',
            onTap: () {
              HudUtil.showInfo('Info Message');
            },
          ),
        ],
      ),
    );
  }
}
