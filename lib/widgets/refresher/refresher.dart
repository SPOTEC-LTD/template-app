import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:template/widgets/placeholder/loading_placeholder.dart';
import 'package:template/widgets/placeholder/no_data_placeholder.dart';

import 'normal_refresh_footer.dart';
import 'normal_refresh_header.dart';
import 'refresh_status.dart';

export 'package:flutter_easyrefresh/easy_refresh.dart';

class Refresher extends StatelessWidget {
  final Widget child;
  final EasyRefreshController controller;
  final RefreshStatus status;
  final bool isListEmpty;
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
    var header = this.header ?? NormalRefreshHedaer(textColor: headerTextColor);
    var footer = this.footer ??
        NormalRefreshFooter(
          textColor: footerTextColor,
          enableInfiniteLoad: enableInfiniteLoad,
          padding: EdgeInsets.only(bottom: bottomPadding),
        );
    var emptyWidget = this.emptyWidget ??
        () {
          switch (status) {
            case RefreshStatus.initial:
              return LoadingPlaceholder();
            case RefreshStatus.failure:
              controller.finishRefresh(success: false);
              return NoDataPlaceholder();
            case RefreshStatus.success:
              controller.finishRefresh(success: !isListEmpty);
              if (isListEmpty) {
                return NoDataPlaceholder();
              }
          }
        }();

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
}
