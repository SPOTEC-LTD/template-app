// Author: Dean.Liu
// DateTime: 2021/08/12 19:45

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// hud 转圈工具类
class HudUtil {
  /// 初始化 EasyLoading
  ///
  /// 设置 [indicatorWidget] 后，[indicatorSize] 将失效
  /// [indicatorWidget] 加载中的 loading 视图
  /// [indicatorSize] loading 视图的大小
  /// [indicatorColor] loading 视图颜色
  /// [successWidget] 操作成功展示的视图
  /// [errorWidget] 操作失败展示的视图
  /// [infoWidget] 提示信息用的视图
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

  /// 显示加载中 hud
  ///
  /// [indicator] loading 视图，覆盖默认值
  static void show({String? status, Widget? indicator}) {
    EasyLoading.show(status: status, indicator: indicator);
  }

  /// 隐藏当前 hud
  static void dismiss({bool animation = true}) {
    EasyLoading.dismiss(animation: animation);
  }

  /// 显示操作成功 hud
  static void showSuccess(String status, {Duration? duration}) {
    EasyLoading.showSuccess(status, duration: duration, dismissOnTap: true);
  }

  /// 显示操作失败 hud
  static void showError(String status, {Duration? duration}) {
    EasyLoading.showError(status, duration: duration, dismissOnTap: true);
  }

  /// 显示提示信息 hud
  static void showInfo(String status, {Duration? duration}) {
    EasyLoading.showInfo(status, duration: duration, dismissOnTap: true);
  }
}
