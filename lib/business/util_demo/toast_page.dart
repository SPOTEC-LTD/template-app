import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:template/basic/utils/toast_util.dart';
import 'package:template/basic/views/base/base_app_bar.dart';
import 'package:template/common/views/title_action_item.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'ToastUtil Demo'),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Bottom Toast',
            onTap: () {
              ToastUtil.show('Bottom Toast');
            },
          ),
          TitleActionItem(
            title: 'Top Toast',
            onTap: () {
              ToastUtil.show('Top Toast', gravity: ToastGravity.TOP);
            },
          ),
          TitleActionItem(
            title: 'Remove Current Toast',
            onTap: () {
              ToastUtil.removeCurrentToast();
            },
          ),
          TitleActionItem(
            title: 'Remove Queued Toasts',
            onTap: () {
              ToastUtil.removeQueuedToasts();
            },
          ),
        ],
      ),
    );
  }
}
