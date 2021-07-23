import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'normal_refresh_footer.dart';
import 'normal_refresh_header.dart';

export 'package:flutter_easyrefresh/easy_refresh.dart';

class Refresher extends StatelessWidget {
  final Widget child;
  final EasyRefreshController controller;
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
