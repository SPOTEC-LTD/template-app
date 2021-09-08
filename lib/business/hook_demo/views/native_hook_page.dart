// Author: Dean.Liu
// DateTime: 2021/08/30 11:22

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../basic/hooks/refresh_hook.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../basic/views/refresher/hook_refresher.dart';
import '../../../common/views/title_action_item.dart';
import '../../cubit_demo/apis/cubit_apis.dart';
import '../../cubit_demo/models/post_entity.dart';

class NativeHookPage extends HookWidget {
  const NativeHookPage({Key? key}) : super(key: key);

  Future<List<PostEntity>> _requestPsots() {
    return CubitApis.getPosts(0);
  }

  @override
  Widget build(BuildContext context) {
    final refreshHook = useRefreshHook<PostEntity>(request: _requestPsots);
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Native Hook Page',
      ),
      body: HookRefresher(
        refreshHook: refreshHook,
        child: ListView.builder(
          itemCount: refreshHook.entities.value.length,
          itemBuilder: (context, index) {
            return TitleActionItem(
                title: refreshHook.entities.value[index].title);
          },
        ),
      ),
    );
  }
}
