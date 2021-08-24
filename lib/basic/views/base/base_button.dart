// Author: Dean.Liu
// DateTime: 2021/08/24 18:20

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    this.child,
    this.text,
    this.size,
    this.color,
    this.disabledColor = CupertinoColors.quaternarySystemFill,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.onPressed,
    this.textColor = Colors.white,
    this.disableTextColor = CupertinoColors.placeholderText,
  }) : super(key: key);

  final Widget? child;
  final String? text;
  final Size? size;
  final Color? color;

  final Color disabledColor;
  final Color textColor;
  final Color disableTextColor;

  final VoidCallback? onPressed;

  final BorderRadius? borderRadius;

  Widget _buildChild() {
    if (child != null) {
      return child!;
    }
    if (text != null) {
      return Text(
        text!,
        style: TextStyle(
          color: onPressed == null ? disabledColor : textColor,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final child = _buildChild();

    final button = CupertinoButton(
      child: child,
      color: color,
      disabledColor: disabledColor,
      borderRadius: borderRadius,
      onPressed: onPressed,
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
