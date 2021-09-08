// Author: Dean.Liu
// DateTime: 2021/08/31 14:10

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../views/refresher/refresh_status.dart';
import 'load_more_entity.dart';

typedef LoadMoreRequest<T> = Future<List<T>> Function(int index);

/// 给刷新列表添加钩子，[T] 为列表数据源的类型
LoadMoreHookEntity<T> useLoadMoreHook<T>(
    {required LoadMoreRequest<T> request, int startIndex = 0}) {
  return use(_LoadMoreHook<T>(request: request, startIndex: startIndex));
}

class _LoadMoreHook<T> extends Hook<LoadMoreHookEntity<T>> {
  final LoadMoreRequest<T> request;
  final int startIndex;

  const _LoadMoreHook({required this.request, required this.startIndex});

  @override
  LoadMoreHookState<T> createState() => LoadMoreHookState<T>();
}

class LoadMoreHookState<E>
    extends HookState<LoadMoreHookEntity<E>, _LoadMoreHook<E>> {
  final _controller = EasyRefreshController();
  late final _values = ValueNotifier<List<E>>([])..addListener(_listenValues);
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
    _values.dispose();
    super.dispose();
  }

  void _listenValues() {
    setState(() {});
  }

  @override
  LoadMoreHookEntity<E> build(BuildContext context) {
    return LoadMoreHookEntity(
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
    _index = 1;
    hook.request(_index).then((values) {
      _status = RefreshStatus.refreshSuccess;
      _noMore = values.isEmpty;
      _values.value = values;
    }).catchError((error) {
      _status = RefreshStatus.refreshFailure;
      setState(() {});
    });
  }

  /// 上拉加载
  void loadMore() {
    final index = _index + 5;
    hook.request(_index).then((values) {
      _index = index;
      _status = RefreshStatus.refreshSuccess;
      _noMore = values.isEmpty;
      _values.value = List.from(_values.value)..addAll(values);
    }).catchError((error) {
      _status = RefreshStatus.refreshFailure;
      setState(() {});
    });
  }
}
