import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FRouter {
  static FRouter? _instance;

  static FRouter _getInstance() {
    _instance ??= FRouter._();
    return _instance!;
  }

  factory FRouter() => _getInstance();
  FRouter._();

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
    var appRouter = FluroRouter.appRouter;
    var match = FluroRouter.appRouter.match(path);
    var appRoute = match?.route;
    Handler handler =
        (appRoute != null ? appRoute.handler : appRouter.notFoundHandler);
    var parameters = match?.parameters ?? <String, List<String>>{};

    FocusManager.instance.primaryFocus?.unfocus();
    return showCupertinoModalBottomSheet<T>(
      context: context,
      settings: routeSettings,
      duration: animated ? const Duration(milliseconds: 250) : Duration.zero,
      builder: (realContext) {
        return handler.handlerFunc(realContext, parameters) ?? Container();
      },
    );
  }

  /// 在嵌套的子路由中pop页面；根据传入的GlobalKey，获取Navigator
  /// 如果Navigator已推出非根子页面，则pop该页面，如果只有根页面，则pop整个Navigator
  Future<bool> popInNestedNavigator({required GlobalKey key}) async {
    var state = key.currentState as NavigatorState?;
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

  void navigateRemote(BuildContext context, String url) {
    if (url.startsWith('http') || url.startsWith('https')) {
      // todo
    } else if (url.startsWith('flutter')) {
      // todo
    } else {
      // todo
    }
  }
}
