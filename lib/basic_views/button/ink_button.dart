import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';

class InkButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final EdgeInsets margin;
  // 文字、icon的颜色
  final Color foregroundColor;
  // 背景纯色
  final Color backgroundColor;
  // 是否启用渐变背景色
  final bool enableGradient;
  // 可点击时的背景渐变色
  final Gradient gradient;
  // 不可点击时的背景渐变色
  final Gradient disabledGradient;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  // 是否显示墨水波纹效果
  final bool enableInk;
  // 扩大点击范围的padding值，不会超出当前组件的父组件
  final EdgeInsets tapPadding;
  final Widget child;

  const InkButton({
    Key? key,
    this.onPressed,
    this.width = 0,
    this.height = 0,
    required this.margin,
    required this.foregroundColor,
    required this.backgroundColor,
    this.enableGradient = false,
    required this.gradient,
    required this.disabledGradient,
    this.borderRadius,
    this.border,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.enableInk = true,
    this.tapPadding = EdgeInsets.zero,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button = TextButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        minimumSize: MaterialStateProperty.all(Size(width, height)),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        )),
        overlayColor:
            enableInk ? null : MaterialStateProperty.all(Colors.transparent),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );

    Gradient? currentGradient;
    if (enableGradient) {
      currentGradient = onPressed == null ? disabledGradient : gradient;
    }
    button = Container(
      clipBehavior: Clip.hardEdge,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
        gradient: currentGradient,
      ),
      child: button,
    );

    return ExpandTapWidget(
      // ExpandTapWidget的createRenderObject不会因为setstate方法重新调用，导致onTap方法始终为第一次传入的方法
      // 每次setstate都会重新创建一个ExpandTapWidget对象，不复用
      key: UniqueKey(),
      child: button,
      onTap: onPressed ?? () {},
      tapPadding: tapPadding,
    );
  }
}
