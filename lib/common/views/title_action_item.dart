import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class TitleActionItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const TitleActionItem({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ThemeProvider.themeOf(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset('assets/images/common_img_no_data_small.png'),
                Text(
                  title,
                  style: controller.data.textTheme.subtitle1,
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
