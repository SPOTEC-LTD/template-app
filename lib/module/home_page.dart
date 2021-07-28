import 'package:flutter/material.dart';
import 'package:template/module/cubit_demo/views/cubit_demo_page.dart';
import 'package:template/routes/common/f_router_common.dart.dart';
import 'package:template/routes/f_router.dart';
import 'package:template/widgets/base/base_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Home',
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
