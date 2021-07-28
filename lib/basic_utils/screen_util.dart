import 'package:flutter/material.dart';

class ScreenUtil {
  static late double screenWidth;
  static late double screenHeight;
  static late double topPadding;
  static late double bottomPadding;
  static late double appBarHeight = 44;
  static late double tabBarHeight = 60;

  /// 屏幕高度减去上下安全区域高度
  static late double safeHeight;
  static late double safeAppBarHeight;
  static late double safeTabBarHeight;

  static late double pixelRatio;

  static void setup(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    topPadding = mediaQueryData.padding.top;
    bottomPadding = mediaQueryData.padding.bottom;
    safeHeight = screenHeight - topPadding - bottomPadding;
    safeAppBarHeight = appBarHeight + topPadding;
    safeTabBarHeight = tabBarHeight + bottomPadding;

    pixelRatio = mediaQueryData.devicePixelRatio;
  }
}
