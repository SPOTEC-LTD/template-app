// Author: Dean.Liu
// DateTime: 2021/08/30 11:22

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../basic/basic_instances.dart';
import '../../basic/views/base/base_app_bar.dart';
import '../../basic/views/refresher/refresh_status.dart';
import '../../basic/views/refresher/refresher.dart';
import '../../common/views/title_action_item.dart';
import '../cubit_demo/apis/cubit_apis.dart';
import '../cubit_demo/models/post_entity.dart';

class HookPage extends HookWidget {
  const HookPage({Key? key}) : super(key: key);

  Future<List<PostEntity>> _requestPsots(int start) {
    return CubitApis.getPosts(start);
  }

  Widget _buildListView(List<PostEntity> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return TitleActionItem(title: posts[index].title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final refreshHook = useRefreshHook<PostEntity>();
    logger.d('build');
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Cubit Demo',
      ),
      body: Refresher(
        controller: refreshHook.value.controller,
        status: refreshHook.value.status,
        isListEmpty: refreshHook.value.values.isEmpty,
        // noMore: state.noMore,
        // onRefresh: () async => cubit.refresh(),
        // onLoad: () async => cubit.loadMore(),
        child: _buildListView(refreshHook.value.values),
      ),
    );
  }
}

class RefreshHookEntity<T> {
  final EasyRefreshController controller;
  final List<T> values;
  final RefreshStatus status;

  RefreshHookEntity(this.controller, this.values, this.status);
}

ValueNotifier<RefreshHookEntity<T>> useRefreshHook<T>() {
  final hook = use(_RefreshHook<T>());
  return useState(hook);
}

class _RefreshHook<T> extends Hook<RefreshHookEntity<T>> {
  const _RefreshHook();

  @override
  _RefreshHookState<T> createState() => _RefreshHookState<T>();
}

class _RefreshHookState<E>
    extends HookState<RefreshHookEntity<E>, _RefreshHook<E>> {
  final _refreshController = EasyRefreshController();
  var values = <E>[];
  var status = RefreshStatus.initial;

  @override
  RefreshHookEntity<E> build(BuildContext context) {
    return RefreshHookEntity(_refreshController, values, status);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void refresh(Future<List<E>> future) {
    future.then((value) {
      values = value;
      status = RefreshStatus.refreshSuccess;
    }).catchError((error) {
      status = RefreshStatus.refreshFailure;
    });
    setState(() {});
  }
}
