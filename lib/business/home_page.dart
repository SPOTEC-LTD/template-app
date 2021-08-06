import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:template/basic/global_instances.dart';
import 'package:template/common/views/title_action_item.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/business/cubit_demo/views/cubit_demo_page.dart';
import 'package:template/business/language_setting/views/language_setting_page.dart';
import 'package:template/business/util_demo/utils_page.dart';
import 'package:template/routes/common/f_router_common.dart.dart';
import 'package:template/basic/router/f_router.dart';
import 'package:template/basic/views/base/base_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    logger.i('Home Pahe Init');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleText: S.of(context).homeTitle,
        leading: Container(),
      ),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Utils Demo',
            onTap: () => _pushUtilsPage(context),
          ),
          TitleActionItem(
            title: 'Cubit Demo',
            onTap: () => _pushCubitPage(context),
          ),
          TitleActionItem(
            title: 'Push Web Page',
            onTap: () => _pushWebPage(context),
          ),
          TitleActionItem(
            title: 'Present Web Page',
            onTap: () => _presentWebPage(context),
          ),
          TitleActionItem(
            title: 'Page Sheet Web Page',
            onTap: () => _pageSheetWebPage(context),
          ),
          TitleActionItem(
            title: 'Remote Web Page',
            onTap: () => _pushRemoteWebPage(context),
          ),
          TitleActionItem(
            title: 'Language Setting',
            onTap: () => _pushLanguageSettingPage(context),
          ),
        ],
      ),
    );
  }

  void _pushUtilsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const UtilsPage();
      }),
    );
  }

  void _pushCubitPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const CubitDemoPage();
      }),
    );
  }

  void _pushWebPage(BuildContext context) {
    final params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    FRouter().push(
      context,
      FRouter().webViewPage,
      routeSettings: RouteSettings(arguments: params),
    );
  }

  void _presentWebPage(BuildContext context) {
    final params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    FRouter().present(
      context,
      FRouter().webViewPage,
      routeSettings: RouteSettings(arguments: params),
    );
  }

  void _pageSheetWebPage(BuildContext context) {
    final params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    FRouter().present(
      context,
      'FRouter().webViewPage',
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

  void _pushLanguageSettingPage(BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
      return const LanguageSettingPage();
    }));
  }
}
