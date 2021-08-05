import 'package:flutter/material.dart';

class TitleActionItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const TitleActionItem({
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(title),
            height: 60,
            alignment: Alignment.centerLeft,
          ),
          const Divider(),
        ],
      ),
      onTap: onTap,
    );
  }
}
