import 'package:flutter/material.dart';
import 'package:template/managers/image_manager.dart';

class NoDataSmallPlaceholder extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;

  const NoDataSmallPlaceholder({
    Key? key,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width,
      height: height,
      alignment: Alignment.center,
      child: Image.asset(
        ImageManager.common_img_no_data_small,
        width: 63,
        height: 64,
      ),
    );
  }
}
