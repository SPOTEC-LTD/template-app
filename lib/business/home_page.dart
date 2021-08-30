import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:template/business/hook_demo/hook_page.dart';

import '../basic/basic_instances.dart';
import '../basic/router/f_router.dart';
import '../basic/views/base/base_app_bar.dart';
import '../common/views/title_action_item.dart';
import '../generated/l10n.dart';
import 'cubit_demo/views/cubit_demo_page.dart';
import 'language_setting/views/language_setting_page.dart';
import 'route_demo/route_home_page.dart';
import 'util_demo/utils_page.dart';

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
      appBar: BaseAppBar(titleText: S.of(context).homeTitle),
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
            title: 'Route Demo',
            onTap: () => _pushRouteDemoPage(context),
          ),
          TitleActionItem(
            title: 'Language Setting',
            onTap: () => _pushLanguageSettingPage(context),
          ),
          TitleActionItem(
            title: 'Hook Demo',
            onTap: () {
              FRouter().pushPage(context, const HookPage());
            },
          ),
        ],
      ),
    );
  }

  void _pushUtilsPage(BuildContext context) {
    FRouter().pushPage(context, const UtilsPage());
  }

  void _pushCubitPage(BuildContext context) {
    FRouter().pushPage(context, const CubitDemoPage());
  }

  void _pushRouteDemoPage(BuildContext context) {
    FRouter().pushPage(context, const RouteHomePage());
  }

  void _pushLanguageSettingPage(BuildContext context) {
    FRouter().pushPage(context, const LanguageSettingPage());
  }
}
