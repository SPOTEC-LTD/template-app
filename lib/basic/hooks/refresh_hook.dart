// Author: Dean.Liu
// DateTime: 2021/08/31 14:10

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_provider/theme_provider.dart';

import '../views/refresher/refresh_status.dart';
import 'refresh_hook_entity.dart';

typedef RefreshHookRequest<T> = Future<List<T>> Function();

/// 给刷新列表添加钩子，[T] 为列表数据源的类型
RefreshHookEntity<T> useRefreshHook<T>(
    {required RefreshHookRequest<T> request}) {
  return use(_RefreshHook<T>(request: request));
}

class _RefreshHook<T> extends Hook<RefreshHookEntity<T>> {
  final RefreshHookRequest<T> request;

  const _RefreshHook({required this.request});

  @override
  RefreshHookState<T> createState() => RefreshHookState<T>();
}

class RefreshHookState<E>
    extends HookState<RefreshHookEntity<E>, _RefreshHook<E>> {
  final _controller = EasyRefreshController();
  late final _values = ValueNotifier<List<E>>([])..addListener(_listenValues);
  var _status = RefreshStatus.initial;
  var _noMore = false;

  @override
  void initHook() {
    super.initHook();
    refresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    _values.dispose();
    super.dispose();
  }

  void _listenValues() {
    setState(() {});
  }

  @override
  RefreshHookEntity<E> build(BuildContext context) {
    return RefreshHookEntity(
      _controller,
      _values,
      _status,
      ThemeProvider.controllerOf(context).theme.data.indicatorColor,
      noMore: _noMore,
      refresh: refresh,
    );
  }

  /// 下拉刷新
  void refresh() {
    hook.request().then((values) {
      _status = RefreshStatus.refreshSuccess;
      _noMore = values.isEmpty;
      _values.value = values;
    }).catchError((error) {
      _status = RefreshStatus.refreshFailure;
      setState(() {});
    });
  }
}
