// Author: Dean.Liu
// DateTime: 2021/08/12 18:45

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

export 'package:fluro/fluro.dart';

/// 路由跳转类，使用前必须先调用 setup 配置
class FRouter {
  /// 工厂方法实现单例
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

  /// 配置远程路由的内部地址
  void setup(String innerUrl) {
    _innerUrl = innerUrl;
  }

  /// 从右往左推出，模块间跳转，依赖路由注册
  ///
  /// [path] 注册的页面路由
  /// [animated] 是否使用动画
  /// [replace] 推出下个页面后，是否删除当前页面
  /// [clearStack] 推出下个页面后，是否清空整个堆栈
  /// [routeSettings] 页面参数
  Future<T?> pushPath<T>(
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

  /// 从下往上推出，模块间跳转，依赖路由注册
  ///
  /// [path] 页面路由
  /// [isFullscreen] 是否全屏推出
  /// [animated] 是否使用动画
  /// [routeSettings] 页面参数
  Future<T?> presentPath<T>(
    BuildContext context,
    String path, {
    bool isFullscreen = true,
    bool animated = true,
    RouteSettings? routeSettings,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isFullscreen) {
      return _presentPathFullScreen<T>(context, path,
          animated: animated, routeSettings: routeSettings);
    } else {
      return _presentPathBottomSheet<T>(context, path,
          animated: animated, routeSettings: routeSettings);
    }
  }

  /// 从下往上全屏推出，模块间跳转
  Future<T?> _presentPathFullScreen<T>(
    BuildContext context,
    String path, {
    bool animated = true,
    RouteSettings? routeSettings,
  }) {
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

  /// 从下往上不占满屏幕推出，模块间跳转
  Future<T?> _presentPathBottomSheet<T>(
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

    return showCupertinoModalBottomSheet<T>(
      context: context,
      settings: routeSettings,
      duration: animated ? const Duration(milliseconds: 250) : Duration.zero,
      builder: (realContext) {
        return handler?.handlerFunc(realContext, parameters) ??
            const SizedBox.shrink();
      },
    );
  }

  /// 从右往左推出，模块内部跳转
  ///
  /// [page] 要推出的页面
  /// [animated] 是否使用动画
  /// [replace] 推出下个页面后，是否删除当前页面
  /// [clearStack] 推出下个页面后，是否清空整个堆栈
  Future<T?> pushPage<T>(
    BuildContext context,
    Widget page, {
    bool animated = true,
    bool replace = false,
    bool clearStack = false,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    final route =
        _buildPageRoute<T>(page, animated: animated, fullscreenDialog: false);
    final navigator = Navigator.of(context);
    if (clearStack) {
      return navigator.pushAndRemoveUntil(route, (check) => false);
    } else {
      if (replace) {
        return navigator.pushReplacement(route);
      } else {
        return navigator.push(route);
      }
    }
  }

  /// 从下往上推出，模块内部跳转
  ///
  /// [isFullscreen] 是否全屏推出
  /// [page] 要推出的页面
  /// [animated] 是否使用动画
  Future<T?> presentPage<T>(
    BuildContext context,
    Widget page, {
    bool isFullscreen = true,
    bool animated = true,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    final nestedNavigatorKey = GlobalKey();
    final nestedNavigator = WillPopScope(
      onWillPop: () => FRouter().androidHardwarePop(key: nestedNavigatorKey),
      child: Navigator(
        key: nestedNavigatorKey,
        onGenerateRoute: (settings) {
          return CupertinoPageRoute(builder: (context) => page);
        },
      ),
    );

    if (isFullscreen) {
      final route = _buildPageRoute<T>(nestedNavigator,
          animated: animated, fullscreenDialog: true);
      final navigator = Navigator.of(context);
      return navigator.push(route);
    } else {
      return showCupertinoModalBottomSheet<T>(
        context: context,
        duration: animated ? const Duration(milliseconds: 250) : Duration.zero,
        builder: (realContext) {
          return nestedNavigator;
        },
      );
    }
  }

  /// 根据是否显示动画，是 push 或者 present 推出方式，返回不同的 Route
  PageRoute<T> _buildPageRoute<T>(
    Widget page, {
    required bool animated,
    required bool fullscreenDialog,
  }) {
    if (animated) {
      return CupertinoPageRoute<T>(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => page,
      );
    } else {
      return PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: Duration.zero,
      );
    }
  }

  /// 推出远程路由
  void pushRemotePath(String path) {
    FocusManager.instance.primaryFocus?.unfocus();
    // 判断远程路由是否以 _innerUrl 开头，确定是否传递给本地路由
    final isUrlInner = _innerUrl != null && path.startsWith(_innerUrl!);
    if (isUrlInner) {
      final uri = Uri.parse(path);
      if (rootOverlayContext == null) {
        return;
      }
      pushPath(rootOverlayContext!, uri.path,
          routeSettings: RouteSettings(arguments: uri.queryParameters));
    } else if (path.startsWith('http') || path.startsWith('https')) {
      // todo
    } else if (path.startsWith('flutter')) {
      // todo
    } else {
      // todo
    }
  }

  /// 返回上级页面，对系统 pop 的封装
  void pop<T>(BuildContext context, {bool rootNavigator = false, T? result}) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context, rootNavigator: rootNavigator).pop(result);
  }

  /// 只用来处理安卓实体键返回的问题，在嵌套的子路由中 pop 页面
  ///
  /// 如果 Navigator 已推出非根子页面，则 pop 该页面，如果只有根页面，则 pop 整个 Navigator
  Future<bool> androidHardwarePop({required GlobalKey key}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final state = key.currentState as NavigatorState?;
    if (state?.canPop() == true) {
      state?.pop();
      // pop 操作交给 Route 的 Navigator，不让 WillPopScope 接管
      return false;
    } else {
      return true;
    }
  }
}
