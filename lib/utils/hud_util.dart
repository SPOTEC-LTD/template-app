import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:template/managers/color_manager.dart';
import 'package:template/services/http/http_service.dart';

class HudUtil {
  static void setup() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60
      ..radius = 8
      // ..backgroundColor = ColorManager.toastBackgroundColor
      ..indicatorColor = ColorManager.backgroundWhite
      ..textColor = ColorManager.textWhite
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

  static void showHttpError(dynamic error, {Duration? duration}) {
    if (error is HttpError) {
      EasyLoading.showError(error.message, duration: duration);
    }
  }
}
