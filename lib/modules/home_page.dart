import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/modules/cubit_demo/views/cubit_demo_page.dart';
import 'package:template/modules/language_setting/views/language_setting_page.dart';
import 'package:template/routes/common/f_router_common.dart.dart';
import 'package:template/routes/f_router.dart';
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
    print('Home Pahe Init');
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
          _ListItem(
            title: 'Cubit Demo',
            onTap: () => _pushCubitPage(context),
          ),
          _ListItem(
            title: 'Push Web Page',
            onTap: () => _pushWebPage(context),
          ),
          _ListItem(
            title: 'Present Web Page',
            onTap: () => _presentWebPage(context),
          ),
          _ListItem(
            title: 'Page Sheet Web Page',
            onTap: () => _pageSheetWebPage(context),
          ),
          _ListItem(
            title: 'Language Setting',
            onTap: () => _pushLanguageSettingPage(context),
          ),
        ],
      ),
    );
  }

  void _pushCubitPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CubitDemoPage();
      }),
    );
  }

  void _pushWebPage(BuildContext context) {
    var params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    FRouter().push(
      context,
      FRouter().webViewPage,
      routeSettings: RouteSettings(arguments: params),
    );
  }

  void _presentWebPage(BuildContext context) {
    var params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    FRouter().present(
      context,
      FRouter().webViewPage,
      routeSettings: RouteSettings(arguments: params),
    );
  }

  void _pageSheetWebPage(BuildContext context) {
    var params = FRouter()
        .webViewPageParams(typeIndex: 1, url: 'https://www.baidu.com/');
    FRouter().present(
      context,
      'FRouter().webViewPage',
      isFullScreen: false,
      routeSettings: RouteSettings(arguments: params),
    );
  }

  void _pushLanguageSettingPage(BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
      return LanguageSettingPage();
    }));
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ListItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            child: Text(title),
            height: 60,
            alignment: Alignment.centerLeft,
          ),
          Divider(),
        ],
      ),
      onTap: onTap,
    );
  }
}
