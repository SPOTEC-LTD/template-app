import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/basic/views/base/base_app_bar.dart';
import 'package:template/business/tools/intl_tool.dart';
import 'package:template/generated/l10n.dart';

class LanguageSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locales = S.delegate.supportedLocales.toList();
    var titles = [
      S.of(context).chiness,
      S.of(context).english,
    ];

    return Scaffold(
      appBar: BaseAppBar(
        titleText: S.of(context).languageSetting,
      ),
      body: ListView.builder(
        itemCount: locales.length,
        itemBuilder: (BuildContext context, int index) {
          return _ListItem(
            title: titles[index],
            onTap: () {
              IntlTools.setLocal(context, locales[index]);
            },
          );
        },
      ),
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
