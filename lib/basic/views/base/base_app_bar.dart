import 'package:flutter/material.dart';

import '../../utils/size_util.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 创建安卓风格的导航栏
  ///
  /// 设置 [title] 后 [titleText]、[titleColor] 都会失效
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
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    final currentNavigator = Navigator.of(context);
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    final isInRootNavigator = currentNavigator == rootNavigator;
    // 当前 route 在根 navigator 的堆栈中，且不可以执行 pop 操作，则不显示返回、关闭按钮
    if (!canPop && isInRootNavigator) {
      return const SizedBox.shrink();
    }
    // 当前 route 是否是嵌套 navigator 的 根路由
    // 是嵌套 navigator 的根路由，则显示关闭图标，点击时使用 rootNavigator pop
    // 不是嵌套 navigator 的根路由，则显示返回图标，点击时使用 currentNavigator pop
    final isNestedNavigatorFirstRoute = !isInRootNavigator && !canPop;
    return IconButton(
      padding: EdgeInsets.zero,
      icon: backImage == null
          ? isNestedNavigatorFirstRoute
              ? const Icon(Icons.close)
              : const Icon(Icons.arrow_back_ios)
          : Image.asset(backImage!),
      onPressed: () {
        if (backCallback == null) {
          if (isNestedNavigatorFirstRoute) {
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
