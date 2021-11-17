// Author: Dean.Liu
// DateTime: 2021/09/08 18:06

import 'package:flutter/cupertino.dart';

import '../../hooks/load_more_entity.dart';
import '../../hooks/refresh_hook_entity.dart';
import 'refresher.dart';

class HookRefresher extends Refresher {
  HookRefresher({required this.refreshHook, required Widget child})
      : super(
          footerTextColor: refreshHook.textColor,
          headerTextColor: refreshHook.textColor,
          controller: refreshHook.controller,
          status: refreshHook.status,
          isListEmpty: refreshHook.entities.value.isEmpty,
          noMore: refreshHook.noMore,
          onRefresh: () async => refreshHook.refresh(),
          onLoad: refreshHook is LoadMoreHookEntity
              ? () async => refreshHook.loadMore()
              : null,
          child: child,
        );

  final RefreshHookEntity refreshHook;
}
