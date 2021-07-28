import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class NormalRefreshFooter extends ClassicalFooter {
  NormalRefreshFooter({
    Color? textColor,
    bool? enableInfiniteLoad,
    EdgeInsets? padding,
  }) : super(
          enableInfiniteLoad: enableInfiniteLoad ?? false,
          enableHapticFeedback: false,
          loadText: '上拉加载',
          loadReadyText: '释放立即加载',
          loadingText: '加载中...',
          loadedText: '加载完成',
          noMoreText: '没有更多了',
          loadFailedText: '加载失败',
          textColor: textColor ?? Colors.black,
          showInfo: false,
          padding: padding,
          completeDuration: Duration(milliseconds: 250),
        );
}
