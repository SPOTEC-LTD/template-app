import 'package:flutter/material.dart';

import '../../../common/consts/color_names.dart';
import '../../../common/consts/icon_names.dart';
import '../../utils/size_util.dart';

/// 后续可能添加webView导航
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

  static double preferredHeight = SizeUtil.appBarHeight;

  @override
  Widget build(BuildContext context) {
    var leading = this.leading;
    if (leading == null) {
      String leadingImage;
      switch (leadingType) {
        case AppBarLeadingType.back:
          leadingImage = brightness == Brightness.dark
              ? IconNames.nav_icon_back_white
              : IconNames.nav_icon_back_gray;
          break;
        case AppBarLeadingType.close:
          leadingImage = brightness == Brightness.dark
              ? IconNames.nav_icon_close_white
              : IconNames.nav_icon_close_gray;
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

    final backColorFormBrightness = brightness == Brightness.dark
        ? ColorNames.background0E1D34
        : ColorNames.backgroundWhite;
    final realBackgroundColor = backgroundColor ?? backColorFormBrightness;

    final textColor = brightness == Brightness.dark
        ? ColorNames.textWhite
        : ColorNames.text242424;

    final title = titleText != null
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
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: ColorNames.lineD8D8D8,
                height: 1,
              ),
            )
          : null,
    );
  }
}
