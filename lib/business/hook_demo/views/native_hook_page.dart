// Author: Dean.Liu
// DateTime: 2021/08/30 11:22

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../basic/hooks/refresh_hook.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../basic/views/refresher/refresher.dart';
import '../../../common/views/title_action_item.dart';
import '../../cubit_demo/apis/cubit_apis.dart';
import '../../cubit_demo/models/post_entity.dart';

class NativeHookPage extends HookWidget {
  const NativeHookPage({Key? key}) : super(key: key);

  Future<List<PostEntity>> _requestPsots(int start) {
    return CubitApis.getPosts(start);
  }

  @override
  Widget build(BuildContext context) {
    final refreshHook = useRefreshHook<PostEntity>(request: _requestPsots);
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Native Hook Page',
      ),
      body: Refresher(
        controller: refreshHook.controller,
        status: refreshHook.status,
        isListEmpty: refreshHook.values.isEmpty,
        noMore: refreshHook.noMore,
        onRefresh: () async => refreshHook.refresh(),
        onLoad: () async => refreshHook.loadMore(),
        child: ListView.builder(
          itemCount: refreshHook.values.length,
          itemBuilder: (context, index) {
            return TitleActionItem(title: refreshHook.values[index].title);
          },
        ),
      ),
    );
  }
}
