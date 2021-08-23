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
    this.elevation,
    this.backImage,
    this.backCallback,
    this.leading,
    this.title,
    this.titleText,
    this.titleColor,
    this.actions,
    this.bottomLine,
  }) : super(key: key);

  /// 设置状态栏文字颜色，[Brightness.dark] 对应白色文字，[Brightness.light] 对应黑色文字
  final Brightness? brightness;

  /// 背景色
  final Color? backgroundColor;

  /// 设置导航栏底部阴影范围
  final double? elevation;

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

  /// 标题文本颜色
  final Color? titleColor;

  /// 导航栏右侧按钮
  final List<Widget>? actions;

  /// 导航栏底部分割线
  final PreferredSize? bottomLine;

  @override
  final Size preferredSize = Size.fromHeight(SizeUtil.appBarHeight);

  Widget _buildBackWidget(BuildContext context) {
    // 是否可以 pop，即是否是 navigator 的根 widget
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    final currentNavigator = Navigator.of(context);
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    final isInRootNavigator = currentNavigator == rootNavigator;
    if (!canPop && isInRootNavigator) {
      return const SizedBox.shrink();
    }
    return IconButton(
      padding: EdgeInsets.zero,
      icon: backImage == null
          ? isInRootNavigator
              ? const Icon(Icons.arrow_back_ios)
              : const Icon(Icons.close)
          : Image.asset(backImage!),
      onPressed: () {
        if (backCallback == null) {
          if (!isInRootNavigator && !canPop) {
            rootNavigator.maybePop();
          } else {
            currentNavigator.maybePop();
          }
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
    return Text(
      titleText!,
      style: TextStyle(
        color: titleColor,
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
