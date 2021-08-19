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

  /// 从右往左推出，模块间跳转
  ///
  /// [path] 注册的页面路由
  /// [animated] 是否使用动画
  /// [replace] 推出下个页面后，是否删除当前页面
  /// [clearStack] 推出下个页面后，是否清空整个堆栈
  /// [routeSettings] 页面参数
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

  /// 从下往上推出，模块间跳转
  ///
  /// [path] 页面路由
  /// [isFullScreen] 是否全屏推出
  /// [animated] 是否使用动画
  /// [routeSettings] 页面参数
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

  /// 从下往上全屏推出
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

  /// 从下往上不占满屏幕推出
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

  /// 在嵌套的子路由中 pop 页面，配合在嵌套路由外包裹的 WillPopScope 用来处理安卓实体键返回的 bug
  ///
  /// 根据传入的 [GlobalKey]，获取 Navigator，如果 Navigator 已推出非根子页面，
  /// 则 pop 该页面，如果只有根页面，则 pop 整个 Navigator
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

  /// 返回上级页面，对系统 pop 的封装
  void pop<T>(BuildContext context, {bool rootNavigator = false, T? result}) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context, rootNavigator: rootNavigator).pop(result);
  }

  /// 推出远程路由
  void navigateRemote(String url) {
    /// 判断远程路由是否以 _innerUrl 开头，确定是否传递给本地路由
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
