import 'package:flutter/material.dart';
import 'package:template/extensions/string_extension.dart';
import 'package:template/module/cubit_demo/views/cubit_demo_page.dart';
import 'package:template/routes/common/common_routes.dart';
import 'package:template/routes/f_router.dart';
import 'package:template/widgets/base/base_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Home',
      ),
      body: ListView(
        children: [
          _ListItem(
            title: 'Cubit Demo',
            onTap: () => _pushCubitPage(context),
          ),
          _ListItem(
            title: 'Common Web Page',
            onTap: () => _pushWebPage(context),
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
    // FRouter.push(context, CommonRoutes.webViewPage,routeSettings: RouteSettings(
    //     arguments: WebViewPageParam(
    //       title: 'Common Web Page',
    //       typeIndex: WebViewPageType.url.index,
    //       url: aboutUrl,
    //     ),
    //   ),);
    var page = FRouter().webViewPage(context);
    FRouter().push2(page: page, context: context);
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
