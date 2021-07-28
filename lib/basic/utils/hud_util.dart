import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:template/business/consts/color_names.dart';

class HudUtil {
  static void setup() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60
      ..radius = 8
      // ..backgroundColor = ColorManager.toastBackgroundColor
      ..indicatorColor = ColorNames.backgroundWhite
      ..textColor = ColorNames.textWhite
      ..userInteractions = false;
    // ..successWidget = Image.asset(ImageManager.common_icon_toast_info)
    // ..infoWidget = Image.asset(ImageManager.common_icon_toast_info)
    // ..errorWidget = Image.asset(ImageManager.common_icon_toast_info);
  }

  static void show() {
    EasyLoading.show();
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }

  static void showSuccess(String status, {Duration? duration}) {
    EasyLoading.showSuccess(status, duration: duration);
  }

  static void showInfo(String status, {Duration? duration}) {
    EasyLoading.showInfo(status, duration: duration);
  }

  static void showError(String status, {Duration? duration}) {
    EasyLoading.showError(status, duration: duration);
  }
}
