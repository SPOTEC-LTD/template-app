import 'package:flutter/material.dart';
import 'ink_button.dart';

class InkGradientButton extends InkButton {
  const InkGradientButton({
    Key? key,
    required VoidCallback onPressed,
    double width = double.infinity,
    double height = 42,
    required EdgeInsets margin,
    required BoxBorder border,
    // 文字、icon的颜色
    Color foregroundColor = Colors.white,
    // 可点击时的背景渐变色
    Gradient gradient =
        const LinearGradient(colors: [Color(0xFF00C9C4), Color(0xFF02A6E3)]),
    // 不可点击时的背景渐变色
    Gradient disabledGradient =
        const LinearGradient(colors: [Color(0xFF00C9C4), Color(0xFF02A6E3)]),
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8)),
    double fontSize = 16,
    required FontWeight fontWeight,
    required String fontFamily,
    // 是否显示墨水波纹效果
    bool enableInk = true,
    // 扩大点击范围的padding值，不会超出当前组件的父组件
    EdgeInsets tapPadding = EdgeInsets.zero,
    required Widget child,
  }) : super(
          key: key,
          backgroundColor: Colors.white,
          border: border,
          onPressed: onPressed,
          enableGradient: true,
          width: width,
          height: height,
          margin: margin,
          foregroundColor: foregroundColor,
          gradient: gradient,
          disabledGradient: disabledGradient,
          borderRadius: borderRadius,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          enableInk: enableInk,
          tapPadding: tapPadding,
          child: child,
        );
}
