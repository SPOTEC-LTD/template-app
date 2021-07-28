import 'package:flutter/material.dart';

/// 弹窗的动画view
// ignore: must_be_immutable
class DialogAnimationView extends StatefulWidget {
  final Widget child;
  // 弹窗消失回调
  VoidCallback? easeOutCompletion;

  late _DialogAnimationViewState _state;

  DialogAnimationView({
    Key? key,
    required this.child,
    this.easeOutCompletion,
  }) : super(key: key);

  @override
  _DialogAnimationViewState createState() {
    _state = _DialogAnimationViewState();
    return _state;
  }

  /// 渐出
  void easeOut() {
    _state.dismiss();
  }
}

class _DialogAnimationViewState extends State<DialogAnimationView>
    with TickerProviderStateMixin {
  /// 动画持续时间
  Duration duration = Duration(milliseconds: 300);

  // 入场动画
  late Animation<double> inAnimation;
  late AnimationController inAnimationController;

  // 退出动画
  late Animation<double> outAnimation;
  late AnimationController outAnimationController;

  // 缩放
  double scale = 0;
  // 透明度
  double opacity = 0;

  @override
  void initState() {
    super.initState();

    // 入场
    inAnimationController =
        AnimationController(vsync: this, duration: duration);
    inAnimation = Tween(begin: 0.7, end: 1.0).animate(inAnimationController)
      ..addListener(() {
        setState(() {
          opacity = 1;
          scale = inAnimation.value;
        });
      });
    inAnimationController.forward();

    // 退场
    outAnimationController =
        AnimationController(vsync: this, duration: duration);
    outAnimation = Tween(begin: 1.0, end: 0.7).animate(outAnimationController)
      ..addListener(() {
        setState(() {
          opacity = 0;
          scale = outAnimation.value;
        });
      })
      ..addStatusListener((status) {
        print(status);
        if (status == AnimationStatus.completed) {
          print('结束了');

          widget.easeOutCompletion?.call();
        }
      });
  }

  @override
  void dispose() {
    inAnimationController.dispose();
    outAnimationController.dispose();
    super.dispose();
  }

  /// 执行退场动画
  void dismiss() {
    if (inAnimationController.isAnimating) {
      inAnimationController.stop();
    }
    outAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: AnimatedOpacity(
        duration: duration,
        opacity: opacity,
        child: Container(
          child: widget.child,
        ),
      ),
    );
  }
}
