import 'package:flutter/material.dart';

class InkWidget extends StatelessWidget {
  final Widget content;

  const InkWidget({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          splashColor: Colors.black12,
          onTap: () {},
          child: content,
        ),
      ),
    );
  }
}
