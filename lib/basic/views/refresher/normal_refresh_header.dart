import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class NormalRefreshHedaer extends ClassicalHeader {
  NormalRefreshHedaer({Color? textColor})
      : super(
          enableHapticFeedback: false,
          showInfo: false,
          refreshText: '下拉刷新',
          refreshReadyText: '释放立即刷新',
          refreshingText: '刷新中...',
          refreshedText: '刷新完成',
          refreshFailedText: '刷新失败',
          noMoreText: '',
          textColor: textColor ?? Colors.black,
          completeDuration: const Duration(milliseconds: 250),
        );
}
