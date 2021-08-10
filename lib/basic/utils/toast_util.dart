import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:template/basic/router/f_router.dart';

class ToastUtil {
  static final _fToast = FToast();
  static EdgeInsetsGeometry? _padding;
  static Color? _backgroundColor;
  static double? _radius;
  static Color? _textColor;
  static double? _fontSize;

  static bool _settedContext = false;

  static void setup({
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    double? radius,
    Color? textColor,
    double? fontSize,
  }) {
    _padding = padding;
    _backgroundColor = backgroundColor;
    _radius = radius;
    _textColor = textColor;
    _fontSize = fontSize;
  }

  static void show(
    String message, {
    Duration? toastDuration,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    if (_settedContext) {
      final toast = _buildToast(message);
      _fToast.showToast(
        child: toast,
        toastDuration: toastDuration,
        gravity: gravity,
      );
    } else {
      if (FRouter.rootOverlayContext != null) {
        _fToast.init(FRouter.rootOverlayContext!);
        _settedContext = true;
        show(message, toastDuration: toastDuration, gravity: gravity);
      }
    }
  }

  static void removeCurrentToast() {
    _fToast.removeCustomToast();
  }

  static void removeQueuedToasts() {
    _fToast.removeQueuedCustomToasts();
  }

  static Widget _buildToast(String message) {
    return Container(
      padding: _padding ??
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_radius ?? 8),
        color: _backgroundColor ?? Colors.black,
      ),
      child: Text(
        message,
        style: TextStyle(
          color: _textColor ?? Colors.white,
          fontSize: _fontSize,
        ),
      ),
    );
  }
}
