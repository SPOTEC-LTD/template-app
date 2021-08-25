// Author: Dean.Liu
// DateTime: 2021/08/24 18:20

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// BaseButton 中子组件的布局顺序
enum ButtonChildDiretion {
  textLeft,
  textRight,
  textTop,
  textBottom,
}

/// iOS 风格的按钮，可以显示图片、文本或者任意子组件
///
/// 设置 [child] 后 [text]、[diableText]、[textColor]、[disableTextColor]
/// [image]、[disableImage] 都会失效，内部子组件的样式将完全依赖与传入的 [child]
///
/// 设置 [textStyle] 并不会影响 [textColor]、[disableTextColor]，它们的优先级更高
class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    this.child,
    this.size,
    this.color,
    this.disabledColor = Colors.black12,
    this.childDirection = ButtonChildDiretion.textRight,
    this.text,
    this.diableText,
    this.textColor = Colors.black,
    this.disableTextColor = Colors.black38,
    this.textStyle,
    this.image,
    this.disableImage,
    this.spacing = 5,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    required this.onPressed,
  }) : super(key: key);

  /// 任意自定义的子组件
  final Widget? child;

  /// 按钮大小
  final Size? size;

  /// 可点击时的背景色
  final Color? color;

  /// 不可点击时的背景色
  final Color disabledColor;

  /// 如果有多个子组件，子组件的排列顺序
  final ButtonChildDiretion childDirection;

  /// 可点击时的文本
  final String? text;

  /// 不可点击时的文本
  final String? diableText;

  /// 可点击时的文字颜色
  final Color textColor;

  /// 不可点击时的文字颜色
  final Color disableTextColor;

  /// 文字样式
  final TextStyle? textStyle;

  /// 可点击时的图片名称
  final String? image;

  /// 不可点击时的图片名称
  final String? disableImage;

  /// 如果同时包含文字和图片，它们之间的间距
  final double spacing;

  /// 圆角大小
  final BorderRadius? borderRadius;

  /// 点击事件
  final VoidCallback? onPressed;

  Widget _buildChild(BuildContext context) {
    if (child != null) {
      return child!;
    }

    final textWidget = _buildText();
    final imageWidget = _buildImage();
    // return imageWidget!;
    // 是否先添加文字
    final addTextFirst = childDirection == ButtonChildDiretion.textLeft ||
        childDirection == ButtonChildDiretion.textTop;
    final firstChild = addTextFirst ? textWidget : imageWidget;
    final secondChild = addTextFirst ? imageWidget : textWidget;
    final List<Widget> children = [];
    if (firstChild != null) {
      children.add(firstChild);
      children.add(SizedBox(width: spacing));
    }
    if (secondChild != null) {
      children.add(secondChild);
    }
    if (children.isNotEmpty) {
      // 子组件布局方向
      final isHorizontal = childDirection == ButtonChildDiretion.textLeft ||
          childDirection == ButtonChildDiretion.textRight;
      return Flex(
        children: children,
        mainAxisAlignment: MainAxisAlignment.center,
        direction: isHorizontal ? Axis.horizontal : Axis.vertical,
      );
    }

    return const SizedBox.shrink();
  }

  Widget? _buildText() {
    final isEnable = onPressed != null;
    final text = isEnable ? this.text : (diableText ?? this.text);
    final colorStyle = isEnable
        ? TextStyle(color: textColor)
        : TextStyle(color: disableTextColor);
    if (text == null) {
      return null;
    } else {
      return Text(
        text,
        style: textStyle == null ? colorStyle : textStyle?.merge(colorStyle),
      );
    }
  }

  Widget? _buildImage() {
    final isEnable = onPressed != null;
    final image = isEnable ? this.image : (disableImage ?? this.image);
    if (image == null) {
      return null;
    } else {
      return Flexible(
        child: Image.asset(
          image,
          fit: BoxFit.fill,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = _buildChild(context);
    final button = CupertinoButton(
      child: child,
      color: color,
      disabledColor: disabledColor,
      padding: size == null ? const EdgeInsets.all(8) : EdgeInsets.zero,
      onPressed: onPressed,
      borderRadius: borderRadius,
    );
    if (size == null) {
      return button;
    } else {
      return SizedBox(
        width: size!.width,
        height: size!.height,
        child: button,
      );
    }
  }
}
