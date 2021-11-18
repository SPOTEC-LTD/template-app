// Author: Dean.Liu
// DateTime: 2021/08/12 20:45

import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';

/// 实现全局注册、通知的功能
final eventBus = EventBus();

/// 替代 print 输出，包含了堆栈信息
final logger = Logger(
  // vscode 必须关闭，不然会乱码
  printer: PrettyPrinter(colors: false),
);
