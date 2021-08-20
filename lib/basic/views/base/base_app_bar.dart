import 'package:flutter/material.dart';

import '../../utils/size_util.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 创建安卓风格的导航栏
  ///
  /// 设置 [backgroundColor] 后 [lightBackgroundColor]、[darkBackgroundColor] 都会失效
  /// 设置 [backButton] 后 [backImage]、[backCallback] 都会失效
  /// 设置 [title] 后 [titleText]、[lightTitleColor]、[darkTitleColor] 都会失效
  BaseAppBar({
    Key? key,
    this.brightness,
    this.backgroundColor,
    this.lightBackgroundColor,
    this.darkBackgroundColor,
    this.elevation,
    this.backButton,
    this.backImage,
    this.backCallback,
    this.leading,
    this.title,
    this.titleText,
    this.lightTitleColor,
    this.darkTitleColor,
    this.actions,
    this.bottomLine,
  }) : super(key: key);

  /// 设置状态栏文字颜色，[Brightness.dark] 对应白色文字，[Brightness.light] 对应黑色文字
  final Brightness? brightness;

  /// 背景色
  final Color? backgroundColor;

  /// 默认的浅色背景色，对应 [Brightness.dark]
  final Color? lightBackgroundColor;

  /// 默认的深色背景色，对应 [Brightness.light]
  final Color? darkBackgroundColor;

  /// 设置导航栏底部阴影范围
  final double? elevation;

  /// 返回按钮
  final Widget? backButton;

  /// 返回按钮图片地址
  final String? backImage;

  /// 返回按钮事件
  final VoidCallback? backCallback;

  /// 左侧额外的组件，位于返回按钮后
  final Widget? leading;

  /// 标题控件
  final Widget? title;

  /// 标题文本
  final String? titleText;

  /// 默认的浅色文字颜色，对应 [Brightness.dark]
  final Color? lightTitleColor;

  /// 默认的深色文字颜色，对应 [Brightness.light]
  final Color? darkTitleColor;

  /// 导航栏右侧按钮
  final List<Widget>? actions;

  /// 导航栏底部分割线
  final PreferredSize? bottomLine;

  @override
  final Size preferredSize = Size.fromHeight(SizeUtil.appBarHeight);

  bool canPop(BuildContext context) {
    final parentRoute = ModalRoute.of(context);
    return parentRoute?.canPop ?? false;
  }

  Widget _buildBackWidget(BuildContext context) {
    if (backButton != null) {
      return backButton!;
    }
    if (!canPop(context)) {
      return const SizedBox.shrink();
    }
    return IconButton(
      padding: EdgeInsets.zero,
      icon: backImage == null
          ? const Icon(Icons.arrow_back_ios)
          : Image.asset(backImage!),
      onPressed: () {
        if (backCallback == null) {
          Navigator.maybePop(context);
        } else {
          backCallback?.call();
        }
      },
    );
  }

  Widget? _buildTitleWidget(BuildContext context) {
    if (title != null) {
      return title;
    }
    if (titleText == null) {
      return null;
    }
    final textColor =
        brightness == Brightness.dark ? lightTitleColor : darkTitleColor;
    return Text(
      titleText!,
      style: TextStyle(
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leftWidgets = Row(children: [
      _buildBackWidget(context),
      leading ?? const SizedBox.shrink(),
    ]);

    final backColorFormBrightness = brightness == Brightness.dark
        ? lightBackgroundColor
        : darkBackgroundColor;
    final backgroundColor = this.backgroundColor ?? backColorFormBrightness;

    return AppBar(
      backgroundColor: backgroundColor,
      leading: leftWidgets,
      title: _buildTitleWidget(context),
      actions: actions,
      elevation: elevation,
      brightness: brightness,
      centerTitle: true,
      bottom: bottomLine,
    );
  }
}
