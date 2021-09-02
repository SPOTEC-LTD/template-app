// Author: Dean.Liu
// DateTime: 2021/09/02 15:57

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:flutter_ume_kit_dio/flutter_ume_kit_dio.dart';
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart';
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart';

import '../../common/http/http_service.dart';

/// UME 调试工具
class UmeUtil {
  /// 将调试工具注入到项目中
  static Widget injectedUmeWidget(Widget child) {
    List<Pluggable> plugins;
    if (kDebugMode) {
      plugins = [
        const WidgetInfoInspector(),
        const WidgetDetailInspector(),
        AlignRuler(),
        const MemoryInfoPage(),
        DioInspector(dio: HttpService.dio),
      ];
    } else {
      plugins = [
        const ColorSucker(),
        AlignRuler(),
        Performance(),
        DioInspector(dio: HttpService.dio),
      ];
    }
    PluginManager.instance.registerAll(plugins);
    return injectUMEWidget(child: child, enable: true);
  }
}
