import 'package:flutter/material.dart';
import 'package:template/module/home/views/cubit_demo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
      child: Container(
        child: Text(title),
        color: Colors.cyan,
        height: 60,
        alignment: Alignment.centerLeft,
      ),
      onTap: onTap,
    );
  }
}
