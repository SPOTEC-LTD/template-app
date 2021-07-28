import 'package:flutter/material.dart';
import 'package:template/managers/image_manager.dart';

class NoDataPlaceholder extends StatelessWidget {
  final int bottomTopRatio;

  const NoDataPlaceholder({
    Key? key,
    this.bottomTopRatio = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 1),
        Image.asset(
          ImageManager.common_img_no_data,
          width: 178,
          height: 151,
        ),
        SizedBox(height: 21),
        Text(
          'S.of(context).noData',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        Spacer(flex: bottomTopRatio),
      ],
    );
  }
}
