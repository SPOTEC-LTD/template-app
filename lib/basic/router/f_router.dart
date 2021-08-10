import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

export 'package:fluro/fluro.dart';

class FRouter {
  factory FRouter() => _instance;
  FRouter._();
  static final FRouter _instance = FRouter._();

  /// 根 Navigator 对应的 key
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  /// rootNavigatorKey.currentState?.overlay?.context
  static BuildContext? get rootOverlayContext =>
      rootNavigatorKey.currentState?.overlay?.context;

  /// 导航页面的生成者，根据传入配置返回 Route
  static RouteFactory? get generator => FluroRouter.appRouter.generator;

  /// 远程路由以该字段开头的，将会传递给本地路由
  String? _innerUrl;

  void setup(String innerUrl) {
    _innerUrl = innerUrl;
  }

  /// 从右往左推出
  Future<T?> push<T>(
    BuildContext context,
    String path, {
    bool animated = true,
    bool replace = false,
    bool clearStack = false,
    RouteSettings? routeSettings,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    return FluroRouter.appRouter
        .navigateTo(
          context,
          path,
          replace: replace,
          clearStack: clearStack,
          transition: animated ? TransitionType.cupertino : TransitionType.none,
          routeSettings: routeSettings,
        )
        .then((value) => value as T?);
  }

  /// 从下往上推出
  Future<T?> present<T>(
    BuildContext context,
    String path, {
    bool isFullScreen = true,
    bool animated = true,
    RouteSettings? routeSettings,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isFullScreen) {
      return _presentFullScreen<T>(context, path,
          animated: animated, routeSettings: routeSettings);
    } else {
      return _presentPageSheet<T>(context, path,
          animated: animated, routeSettings: routeSettings);
    }
  }

  /// 全屏推出
  Future<T?> _presentFullScreen<T>(
    BuildContext context,
    String path, {
    bool animated = true,
    RouteSettings? routeSettings,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    return FluroRouter.appRouter
        .navigateTo(
          context,
          path,
          rootNavigator: true,
          transition: animated
              ? TransitionType.cupertinoFullScreenDialog
              : TransitionType.none,
          transitionDuration: const Duration(milliseconds: 250),
          routeSettings: routeSettings,
        )
        .then((value) => value as T?);
  }

  /// 不占满屏幕
  Future<T?> _presentPageSheet<T>(
    BuildContext context,
    String path, {
    bool animated = true,
    RouteSettings? routeSettings,
  }) {
    final appRouter = FluroRouter.appRouter;
    final match = FluroRouter.appRouter.match(path);
    final appRoute = match?.route;
    final handler = appRoute != null
        ? (appRoute.handler as Handler)
        : appRouter.notFoundHandler;
    final parameters = match?.parameters ?? <String, List<String>>{};

    FocusManager.instance.primaryFocus?.unfocus();
    return showCupertinoModalBottomSheet<T>(
      context: context,
      settings: routeSettings,
      duration: animated ? const Duration(milliseconds: 250) : Duration.zero,
      builder: (realContext) {
        return handler?.handlerFunc(realContext, parameters) ?? Container();
      },
    );
  }

  /// 在嵌套的子路由中pop页面；根据传入的GlobalKey，获取Navigator
  /// 如果Navigator已推出非根子页面，则pop该页面，如果只有根页面，则pop整个Navigator
  Future<bool> popInNestedNavigator({required GlobalKey key}) async {
    final state = key.currentState as NavigatorState?;
    if (state == null) return true;
    if (state.canPop()) {
      state.pop();
      return false;
    } else {
      return true;
    }
  }

  void pop<T>(BuildContext context, {bool rootNavigator = false, T? result}) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context, rootNavigator: rootNavigator).pop(result);
  }

  void navigateRemote(String url) {
    /// 判断远程路由是否以_innerUrl开头，确定是否传递给本地路由
    final isUrlInner = _innerUrl != null && url.startsWith(_innerUrl!);
    if (isUrlInner) {
      final uri = Uri.parse(url);
      if (rootOverlayContext == null) {
        return;
      }
      push(rootOverlayContext!, uri.path,
          routeSettings: RouteSettings(arguments: uri.queryParameters));
    } else if (url.startsWith('http') || url.startsWith('https')) {
      // todo
    } else if (url.startsWith('flutter')) {
      // todo
    } else {
      // todo
    }
  }
}
