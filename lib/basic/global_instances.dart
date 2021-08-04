import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';

/// 实现通知中心的效果
final eventBus = EventBus();

/// 替代print输出，包含了堆栈信息
final logger = Logger(
  // vscode必须关闭，不然会乱码
  printer: PrettyPrinter(colors: false),
);
