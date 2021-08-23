// Author: Dean.Liu
// DateTime: 2021/08/23 10:33

import 'package:flutter/material.dart';

import '../../basic/router/f_router.dart';
import '../../basic/views/base/base_app_bar.dart';
import '../../common/views/title_action_item.dart';
import '../../routes/common/f_router_common.dart.dart';
import '../../routes/route_demo/f_router_route_demo.dart';

class RouteHomePage extends StatelessWidget {
  const RouteHomePage({Key? key}) : super(key: key);

  void _pushWebPage(BuildContext context) {
    final params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    FRouter().push(
      context,
      FRouter().webViewPage,
      routeSettings: RouteSettings(arguments: params),
    );
  }

  void _presentNestedNavigator(BuildContext context) {
    FRouter().present(context, FRouter().nestedRouteNavigatorPath);
  }

  void _presentNotFullscreen(BuildContext context) {
    final params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    FRouter().present(
      context,
      'Invalid Path',
      isFullScreen: false,
      routeSettings: RouteSettings(arguments: params),
    );
  }

  void _pushRemoteWebPage(BuildContext context) {
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
    FRouter().navigateRemote(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'Route Demo'),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Push WebView',
            onTap: () => _pushWebPage(context),
          ),
          TitleActionItem(
            title: 'Fullscreen Present NestedNavigator',
            onTap: () => _presentNestedNavigator(context),
          ),
          TitleActionItem(
            title: 'Not Fullscreen Present Invalid Path',
            onTap: () => _presentNotFullscreen(context),
          ),
          TitleActionItem(
            title: 'Remote Push',
            onTap: () => _pushRemoteWebPage(context),
          ),
        ],
      ),
    );
  }
}
