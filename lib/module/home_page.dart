import 'package:flutter/material.dart';
import 'package:template/module/cubit_demo/views/cubit_demo_page.dart';
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
            title: 'CubitDemo',
            onTap: () => _pushCubitPage(context),
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
