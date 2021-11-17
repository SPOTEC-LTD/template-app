// Date:2021/11/17 11:01 上午
// author:jack
// des:
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

/// 自定义主题 目前就两种主题色（dark+light）
class CustomTheme {
  static const String appLightThemeId = 'light';
  static const String appDarkThemeId = 'dark';

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, // 亮色主题
    //(按钮)Widget 前景色为白色
    // colorScheme: ColorScheme?.fromSwatch().copyWith(secondary: Colors.black26),
    indicatorColor: Colors.blueGrey,
    // App主要部分的背景色（ToolBar,TabBar等）。
    primaryColor: Colors.amberAccent,
    // iconTheme:IconThemeData(color: Colors.grey),//icon 主题为灰色
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: TextStyle(
        color: Colors.black12,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      subtitle1: TextStyle(color: Colors.black, fontSize: 18),
      subtitle2: TextStyle(color: Colors.amberAccent, fontSize: 16),
    ), // 文本主题为黑色
    iconTheme: const IconThemeData(color: Colors.amberAccent),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, //(按钮)Widget 前景色为黑色
    primaryColor: Colors.black, // 主题色
    indicatorColor: Colors.blueGrey,
    // iconTheme:IconThemeData(color: Colors.blue),//icon 主题色为蓝色
    // colorScheme: ColorScheme?.fromSwatch().copyWith(secondary: Colors.white),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      subtitle1: TextStyle(color: Colors.amber, fontSize: 18),
      subtitle2: TextStyle(color: Colors.amberAccent, fontSize: 16),
    ), // 文本主题色为红色
    iconTheme: const IconThemeData(color: Colors.white),
  );

  static AppTheme get appLightTheme => AppTheme(
        id: appLightThemeId,
        data: lightTheme,
        description: 'light theme',
      );

  static AppTheme get appDarkTheme => AppTheme(
        id: appDarkThemeId,
        data: darkTheme,
        description: 'dark theme',
      );
}
