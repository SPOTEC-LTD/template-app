import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:template/basic_views/placeholder/loading_placeholder.dart';
import 'package:template/basic_views/placeholder/no_data_placeholder.dart';

import 'normal_refresh_footer.dart';
import 'normal_refresh_header.dart';
import 'refresh_status.dart';

export 'package:flutter_easyrefresh/easy_refresh.dart';

class Refresher extends StatelessWidget {
  final Widget child;
  final EasyRefreshController controller;
  final RefreshStatus status;
  final bool isListEmpty;
  final bool noMore;
  final ScrollController? scrollController;
  final bool firstRefresh;
  final Color? headerTextColor;
  final Color? footerTextColor;
  final Header? header;
  final Footer? footer;
  final Widget? emptyWidget;
  final OnRefreshCallback? onRefresh;
  final OnLoadCallback? onLoad;
  final bool? enableInfiniteLoad;
  final double bottomPadding;

  const Refresher({
    Key? key,
    required this.child,
    required this.controller,
    required this.status,
    required this.isListEmpty,
    this.noMore = false,
    this.scrollController,
    this.firstRefresh = false,
    this.headerTextColor,
    this.footerTextColor,
    this.header,
    this.footer,
    this.emptyWidget,
    this.onRefresh,
    this.onLoad,
    this.enableInfiniteLoad,
    this.bottomPadding = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _finishAnimate();

    var header = this.header ?? NormalRefreshHedaer(textColor: headerTextColor);
    var footer = this.footer ??
        NormalRefreshFooter(
          textColor: footerTextColor,
          enableInfiniteLoad: enableInfiniteLoad,
          padding: EdgeInsets.only(bottom: bottomPadding),
        );
    var emptyWidget = this.emptyWidget ?? _buildEmptyWidget();

    return EasyRefresh(
      firstRefresh: firstRefresh,
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      controller: controller,
      scrollController: scrollController,
      header: header,
      footer: footer,
      emptyWidget: emptyWidget,
      onRefresh: onRefresh,
      onLoad: onLoad,
      child: child,
    );
  }

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

  Widget? _buildEmptyWidget() {
    switch (status) {
      case RefreshStatus.initial:
        return LoadingPlaceholder();
      case RefreshStatus.refreshSuccess:
        controller.finishRefresh();
        if (isListEmpty) {
          return NoDataPlaceholder();
        }
        return null;
      case RefreshStatus.refreshFailure:
        controller.finishRefresh(success: false);
        return NoDataPlaceholder();
      default:
        return null;
    }
  }
}
