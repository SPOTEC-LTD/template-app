// Author: Dean.Liu
// DateTime: 2021/09/08 11:35

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../views/refresher/refresh_status.dart';

import 'refresh_hook_entity.dart';

/// 刷新列表需要的所有元素的容器类
class LoadMoreHookEntity<T> extends RefreshHookEntity<T> {
  /// 上拉加载方法
  final VoidCallback loadMore;

  LoadMoreHookEntity(
    EasyRefreshController controller,
    ValueNotifier<List<T>> entities,
    RefreshStatus status, {
    required bool noMore,
    required VoidCallback refresh,
    required this.loadMore,
  }) : super(
          controller,
          entities,
          status,
          noMore: noMore,
          refresh: refresh,
        );
}
