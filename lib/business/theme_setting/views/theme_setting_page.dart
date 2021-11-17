import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../basic/views/base/base_app_bar.dart';
import '../../../generated/l10n.dart';

class ThemeSettingPage extends StatelessWidget {
  const ThemeSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ThemeProvider.controllerOf(context);

    final themes = controller.allThemes;

    return Scaffold(
      appBar: BaseAppBar(
        titleText: S.of(context).themeSetting,
        backgroundColor: controller.theme.data.primaryColor,
      ),
      body: ListView.builder(
        itemCount: themes.length,
        itemBuilder: (BuildContext context, int index) {
          return _ListItem(
            title: themes[index].description,
            onTap: () {
              controller.setTheme(themes[index].id);
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
    final controller = ThemeProvider.controllerOf(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          const Icon(Icons.admin_panel_settings),
          Text(
            title,
            style: controller.theme.data.textTheme.subtitle1,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
