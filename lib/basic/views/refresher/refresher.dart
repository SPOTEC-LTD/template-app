import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../placeholder/loading_placeholder.dart';
import '../placeholder/no_data_placeholder.dart';
import 'normal_refresh_footer.dart';
import 'normal_refresh_header.dart';
import 'refresh_status.dart';

export 'package:flutter_easyrefresh/easy_refresh.dart';

class Refresher extends StatelessWidget {
  /// 子控件
  final Widget child;

  /// 刷新控制器
  final EasyRefreshController controller;

  /// 子控件当前刷新状态
  final RefreshStatus status;

  /// 数据源是否为空
  final bool isListEmpty;

  /// 是否还有更多数据
  final bool noMore;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 头部文字颜色
  final Color? headerTextColor;

  /// 尾部文字颜色
  final Color? footerTextColor;

  /// 头部控件
  final Header? header;

  /// 尾部控件
  final Footer? footer;

  /// 各种刷新状态的占位图
  final Widget? placeholder;

  /// 下拉刷新回调
  final OnRefreshCallback? onRefresh;

  /// 上拉加载更多回调
  final OnLoadCallback? onLoad;

  /// 是否开启无限加载，开启时没有上拉再回弹的效果
  final bool? enableInfiniteLoad;

  /// 尾部缩进
  final double bottomPadding;

  const Refresher({
    Key? key,
    required this.child,
    required this.controller,
    required this.status,
    required this.isListEmpty,
    this.noMore = false,
    this.scrollController,
    this.headerTextColor,
    this.footerTextColor,
    this.header,
    this.footer,
    this.placeholder,
    this.onRefresh,
    this.onLoad,
    this.enableInfiniteLoad,
    this.bottomPadding = 0.0,
  }) : super(key: key);

  void _finishAnimate() {
    switch (status) {
      case RefreshStatus.refreshSuccess:
        controller.finishRefresh();
        if (onLoad != null) {
          controller.resetLoadState();
          controller.finishLoad(noMore: noMore);
        }
        break;
      case RefreshStatus.refreshFailure:
        controller.finishRefresh(success: false);
        if (onLoad != null) {
          controller.resetLoadState();
          controller.finishLoad(noMore: noMore);
        }
        break;
      case RefreshStatus.loadMoreSuccess:
        controller.finishLoad(noMore: noMore);
        break;
      case RefreshStatus.loadMoreFailure:
        controller.finishRefresh(success: false);
        break;
      default:
        break;
    }
  }

  Widget? _buildPlaceholderWidget() {
    switch (status) {
      case RefreshStatus.initial:
        return const LoadingPlaceholder();
      case RefreshStatus.refreshSuccess:
        controller.finishRefresh();
        if (isListEmpty) {
          return const NoDataPlaceholder();
        }
        return null;
      case RefreshStatus.refreshFailure:
        controller.finishRefresh(success: false);
        // return const NoDataPlaceholder();
        return null;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _finishAnimate();

    final header =
        this.header ?? NormalRefreshHedaer(textColor: headerTextColor);
    final footer = this.footer ??
        NormalRefreshFooter(
          textColor: footerTextColor,
          enableInfiniteLoad: enableInfiniteLoad,
          padding: EdgeInsets.only(bottom: bottomPadding),
        );
    final placeholder = this.placeholder ?? _buildPlaceholderWidget();

    return EasyRefresh(
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      controller: controller,
      scrollController: scrollController,
      header: header,
      footer: footer,
      emptyWidget: placeholder,
      onRefresh: onRefresh,
      onLoad: onLoad,
      child: child,
    );
  }
}
