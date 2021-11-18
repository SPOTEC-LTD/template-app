// Author: Dean.Liu
// DateTime: 2021/08/12 19:45

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../router/f_router.dart';

/// toast 工具类
class ToastUtil {
  static final _fToast = FToast();
  static EdgeInsetsGeometry? _padding;
  static Color? _backgroundColor;
  static double? _radius;
  static Color? _textColor;
  static double? _fontSize;
  // 是否已经设置过 context
  static bool _settedContext = false;

  /// 配置 util
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

  /// 显示 toast
  ///
  /// [gravity] toast 显示的位置
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

  /// 隐藏当前 toast
  static void removeCurrentToast() {
    _fToast.removeCustomToast();
  }

  /// 移除队列中的所有 toast
  static void removeQueuedToasts() {
    _fToast.removeQueuedCustomToasts();
  }

  /// 根据 setup 传入的配置生成 toast 视图
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
