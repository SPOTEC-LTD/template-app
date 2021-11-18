// Author: Dean.Liu
// DateTime: 2021/08/12 19:45

import 'package:flutter/material.dart';

/// 各种视图大小工具类
class SizeUtil {
  static MediaQueryData? _queryData;

  /// 状态栏高度
  static double get appBarHeight => _appBarHeight ?? kToolbarHeight;
  static double? _appBarHeight;

  /// tabbar 高度
  static double get tabBarHeight => _tabBarHeight ?? kBottomNavigationBarHeight;
  static double? _tabBarHeight;

  /// 每个逻辑点包含的像素值，可能为非整数
  static late double devicePixelRatio;

  /// 屏幕宽度，切换横竖屏后可实时获取
  static double get screenWidth => _queryData?.size.width ?? 0;

  /// 屏幕高度，切换横竖屏后可实时获取
  static double get screenHeight => _queryData?.size.height ?? 0;

  /// 屏幕顶部安全区域高度，切换横竖屏后可实时获取
  static double get topPadding => _queryData?.padding.top ?? 0;

  /// 屏幕底部安全区域高度，切换横竖屏后可实时获取
  static double get bottomPadding => _queryData?.padding.bottom ?? 0;

  /// 屏幕高度 - 上下安全区域高度
  static double get safeScreenHeight =>
      screenHeight - topPadding - bottomPadding;

  /// 顶部安全区域高度+导航栏高度
  static double get safeAppBarHeight => appBarHeight + topPadding;

  /// 底部安全区域高度 + tab栏高度
  static double get safeTabBarHeight => tabBarHeight + bottomPadding;

  /// 配置 util
  ///
  /// [appBarHeight] 默认值为值 [kToolbarHeight]
  /// [tabBarHeight] 默认值为值 [kBottomNavigationBarHeight]
  static void setup(
    BuildContext context, {
    double? appBarHeight,
    double? tabBarHeight,
  }) {
    _queryData = MediaQuery.of(context);
    devicePixelRatio = _queryData!.devicePixelRatio;
    _appBarHeight = appBarHeight;
    _tabBarHeight = tabBarHeight;
  }
}
