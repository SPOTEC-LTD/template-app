import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../basic/utils/intl_util.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../generated/l10n.dart';

class LanguageSettingPage extends StatelessWidget {
  const LanguageSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locales = S.delegate.supportedLocales.toList();
    final titles = [
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
              IntlUtil.setLocal(context, locales[index]);
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
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            child: Text(title),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
