// Author: Dean.Liu
// DateTime: 2021/08/23 10:33

import 'package:flutter/material.dart';

import '../../basic/router/f_router.dart';
import '../../basic/views/base/base_app_bar.dart';
import '../../common/views/title_action_item.dart';
import '../../routes/common/f_router_common.dart.dart';
import '../../routes/route_demo/f_router_route_demo.dart';
import 'nested_route_home_page.dart';

class RouteHomePage extends StatelessWidget {
  const RouteHomePage({Key? key}) : super(key: key);

  void _pushPathNestedRouteHome(BuildContext context) {
    FRouter().pushPath(context, FRouter().nestedRouteHomePage);
  }

  void _pushPageNestedRouteHome(BuildContext context) {
    FRouter().pushPage(context, const NestedRouteHomePage());
  }

  void _pushPathInvalidPath(BuildContext context) {
    FRouter().pushPath(context, 'Invalid Path');
  }

  void _presentPathNestedRouteHome(BuildContext context) {
    FRouter().presentPath(context, FRouter().nestedRouteNavigatorPath);
  }

  void _presentPathBottomSheet(BuildContext context) {
    FRouter().presentPath(context, FRouter().nestedRouteNavigatorPath,
        isFullscreen: false);
  }

  void _presentPageNestedRouteHome(BuildContext context) {
    FRouter().presentPage(context, const NestedRouteHomePage());
  }

  void _presentPageBottomSheet(BuildContext context) {
    FRouter()
        .presentPage(context, const NestedRouteHomePage(), isFullscreen: false);
  }

  void _pushRemotePath(BuildContext context) {
    final params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    params.removeWhere((key, value) => value == null);
    params.updateAll((key, value) => value.toString());
    final uri = Uri(
      scheme: 'http',
      host: 'app.template.com',
      path: 'webView/webViewPage',
      queryParameters: params,
    );
    FRouter().pushRemotePath(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'Route Demo'),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Push Path: NestedRouteHomePage',
            onTap: () => _pushPathNestedRouteHome(context),
          ),
          TitleActionItem(
            title: 'Push Page: NestedRouteHomePage',
            onTap: () => _pushPageNestedRouteHome(context),
          ),
          TitleActionItem(
            title: 'Push Path: Invalid Path',
            onTap: () => _pushPathInvalidPath(context),
          ),
          TitleActionItem(
            title: 'Present Path Fullscreen: NestedRouteHomePage',
            onTap: () => _presentPathNestedRouteHome(context),
          ),
          TitleActionItem(
            title: 'Present Path Bottom Sheet: NestedRouteHomePage',
            onTap: () => _presentPathBottomSheet(context),
          ),
          TitleActionItem(
            title: 'Present Page Fullscreen: NestedRouteHomePage',
            onTap: () => _presentPageNestedRouteHome(context),
          ),
          TitleActionItem(
            title: 'Present Page Bottom Sheet: NestedRouteHomePage',
            onTap: () => _presentPageBottomSheet(context),
          ),
          TitleActionItem(
            title: 'Push Remote Path',
            onTap: () => _pushRemotePath(context),
          ),
        ],
      ),
    );
  }
}
