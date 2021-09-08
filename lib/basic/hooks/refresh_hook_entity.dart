// Author: Dean.Liu
// DateTime: 2021/09/08 11:35

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../views/refresher/refresh_status.dart';

/// 刷新列表需要的所有元素的容器类
class RefreshHookEntity<T> {
  /// [EasyRefresh] 控件的控制器
  final EasyRefreshController controller;

  /// 列表数据源
  final ValueNotifier<List<T>> entities;

  /// 当前列表的刷新状态
  final RefreshStatus status;

  /// 是否还有更多数据
  final bool noMore;

  /// 下拉刷新方法
  final VoidCallback refresh;

  RefreshHookEntity(
    this.controller,
    this.entities,
    this.status, {
    required this.noMore,
    required this.refresh,
  });
}
