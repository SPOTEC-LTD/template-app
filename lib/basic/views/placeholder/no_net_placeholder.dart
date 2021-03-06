import 'package:flutter/material.dart';

class NoNetPlaceholder extends StatelessWidget {
  final Color? color;
  final double? height;
  final BoxDecoration? decoration;
  final int bottomTopRatio;
  final VoidCallback? onRetry;

  const NoNetPlaceholder({
    Key? key,
    this.color,
    this.height,
    this.decoration,
    this.bottomTopRatio = 3,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      decoration: decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/common_img_no_net.png',
            width: 178,
            height: 151,
          ),
          const SizedBox(height: 21),
          const Text(
            'S.of(context).noNet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 17),
          // InkGradientButton(
          //   width: 143,
          //   height: 37,
          //   fontSize: 18,
          //   borderRadius: BorderRadius.circular(18.5),
          //   child: Text(S.of(context).noNetLoadMore),
          //   onPressed: onRetry,
          // ),
          Spacer(flex: bottomTopRatio),
        ],
      ),
    );
  }
}
