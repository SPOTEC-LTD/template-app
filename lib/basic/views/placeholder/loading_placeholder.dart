import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({
    Key? key,
    this.bottomTopRatio = 3,
  }) : super(key: key);

  final int bottomTopRatio;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        SizedBox(
          width: 28,
          height: 28,
          child: LoadingIndicator(
            indicatorType: Indicator.circleStrokeSpin,
            colors: const [Colors.cyan],
          ),
        ),
        Spacer(flex: bottomTopRatio),
      ],
    );
  }
}
