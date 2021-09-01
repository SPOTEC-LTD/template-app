// Author: Dean.Liu
// DateTime: 2021/08/31 14:10

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../views/refresher/refresh_status.dart';

typedef RefreshHookRequest<T> = Future<List<T>> Function(int index);

/// 刷新列表需要的所有元素的容器类
class RefreshHookEntity<T> {
  /// [EasyRefresh] 控件的控制器
  final EasyRefreshController controller;

  /// 列表数据源
  final List<T> values;

  /// 当前列表的刷新状态
  final RefreshStatus status;

  /// 是否还有更多数据
  final bool noMore;

  /// 下拉刷新方法
  final VoidCallback refresh;

  /// 上拉加载方法
  final VoidCallback loadMore;

  RefreshHookEntity(
    this.controller,
    this.values,
    this.status, {
    required this.noMore,
    required this.refresh,
    required this.loadMore,
  });
}

/// 给刷新列表添加钩子，[T] 为列表数据源的类型
RefreshHookEntity<T> useRefreshHook<T>(
    {required RefreshHookRequest<T> request, int startIndex = 0}) {
  return use(_RefreshHook<T>(request: request, startIndex: startIndex));
}

class _RefreshHook<T> extends Hook<RefreshHookEntity<T>> {
  final RefreshHookRequest<T> request;
  final int startIndex;

  const _RefreshHook({required this.request, required this.startIndex});

  @override
  RefreshHookState<T> createState() => RefreshHookState<T>();
}

class RefreshHookState<E>
    extends HookState<RefreshHookEntity<E>, _RefreshHook<E>> {
  final _controller = EasyRefreshController();
  var _values = <E>[];
  var _status = RefreshStatus.initial;
  var _noMore = false;
  late int _index;

  @override
  void initHook() {
    super.initHook();
    _index = hook.startIndex;
    refresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  RefreshHookEntity<E> build(BuildContext context) {
    return RefreshHookEntity(
      _controller,
      _values,
      _status,
      noMore: _noMore,
      refresh: refresh,
      loadMore: loadMore,
    );
  }

  /// 下拉刷新
  void refresh() {
    hook.request(_index).then((value) {
      _values = value;
      _status = RefreshStatus.refreshSuccess;
      _noMore = value.isEmpty;
      setState(() {});
    }).catchError((error) {
      _status = RefreshStatus.refreshFailure;
      setState(() {});
    });
  }

  /// 上拉加载
  void loadMore() {
    final index = _index + 5;
    hook.request(_index).then((value) {
      _index = index;
      _values.addAll(value);
      _status = RefreshStatus.refreshSuccess;
      _noMore = value.isEmpty;
      setState(() {});
    }).catchError((error) {
      _status = RefreshStatus.refreshFailure;
      setState(() {});
    });
  }
}
