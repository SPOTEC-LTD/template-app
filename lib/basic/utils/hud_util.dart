import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HudUtil {
  /// 初始化hud
  ///
  /// 设置[indicatorWidget]后，[indicatorSize]将失效
  static void setup({
    Color backgroundColor = Colors.black,
    Widget? indicatorWidget,
    double indicatorSize = 60,
    Color indicatorColor = Colors.white,
    Color? textColor = Colors.white,
    double radius = 8,
    Duration displayDuration = const Duration(milliseconds: 1500),
    Widget? successWidget,
    Widget? errorWidget,
    Widget? infoWidget,
  }) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..userInteractions = false
      ..indicatorWidget = indicatorWidget
      ..indicatorSize = indicatorSize
      ..radius = radius
      ..backgroundColor = backgroundColor
      ..indicatorColor = indicatorColor
      ..textColor = textColor
      ..displayDuration = displayDuration
      ..successWidget = successWidget
      ..errorWidget = errorWidget
      ..infoWidget = infoWidget;
  }

  static void show({
    String? status,
    Widget? indicator,
    bool dismissOnTap = false,
  }) {
    EasyLoading.show(
      status: status,
      indicator: indicator,
      dismissOnTap: dismissOnTap,
    );
  }

  static void dismiss({bool animation = true}) {
    EasyLoading.dismiss(animation: animation);
  }

  static void showSuccess(String status, {Duration? duration}) {
    EasyLoading.showSuccess(status, duration: duration);
  }

  static void showInfo(String status, {Duration? duration}) {
    EasyLoading.showInfo(status, duration: duration);
  }

  static void showError(String status, {Duration? duration}) {
    EasyLoading.showError(status, duration: duration);
  }
}
