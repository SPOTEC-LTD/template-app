import 'package:flutter/material.dart';

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
        const Spacer(),
        Image.asset(
          'assets/images/common_img_no_data.png',
          width: 178,
          height: 151,
        ),
        const SizedBox(height: 21),
        const Text(
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
