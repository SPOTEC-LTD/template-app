import 'package:flutter/material.dart';
import 'package:template/managers/color_manager.dart';
import 'package:template/managers/icon_manager.dart';
import 'package:template/basic_utils/screen_util.dart';

// 后续可能添加webView导航
enum AppBarLeadingType {
  back,
  close,
}

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Widget? leading;
  final AppBarLeadingType leadingType;
  final VoidCallback? leadingAction;
  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final double? elevation;
  final Brightness brightness;
  final bool? isCenter;
  final bool? showLine;
  @override
  final Size preferredSize = Size.fromHeight(preferredHeight);

  BaseAppBar({
    Key? key,
    this.backgroundColor,
    this.leading,
    this.leadingType = AppBarLeadingType.back,
    this.leadingAction,
    this.title,
    this.titleText,
    this.actions,
    this.elevation,
    this.brightness = Brightness.dark,
    this.isCenter = true,
    this.showLine = false,
  }) : super(key: key);

  static double preferredHeight = ScreenUtil.appBarHeight;

  @override
  Widget build(BuildContext context) {
    var leading = this.leading;
    if (leading == null) {
      var leadingImage;
      switch (leadingType) {
        case AppBarLeadingType.back:
          leadingImage = brightness == Brightness.dark
              ? IconManager.nav_icon_back_white
              : IconManager.nav_icon_back_gray;
          break;
        case AppBarLeadingType.close:
          leadingImage = brightness == Brightness.dark
              ? IconManager.nav_icon_close_white
              : IconManager.nav_icon_close_gray;
          break;
      }
      leading = IconButton(
        icon: Image.asset(leadingImage),
        onPressed: () {
          if (leadingAction == null) {
            Navigator.maybePop(context);
          } else {
            leadingAction?.call();
          }
        },
      );
    }

    var backColorFormBrightness = brightness == Brightness.dark
        ? ColorManager.background0E1D34
        : ColorManager.backgroundWhite;
    var realBackgroundColor = backgroundColor ?? backColorFormBrightness;

    var textColor = brightness == Brightness.dark
        ? ColorManager.textWhite
        : ColorManager.text242424;

    var title = titleText != null
        ? Text(
            titleText!,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          )
        : this.title;

    return AppBar(
      backgroundColor: realBackgroundColor,
      leading: leading,
      title: title,
      actions: actions,
      elevation: elevation ?? 0,
      brightness: brightness,
      centerTitle: isCenter,
      bottom: showLine == true
          ? PreferredSize(
              child: Container(
                color: ColorManager.lineD8D8D8,
                height: 1,
              ),
              preferredSize: Size.fromHeight(1),
            )
          : null,
    );
  }
}
