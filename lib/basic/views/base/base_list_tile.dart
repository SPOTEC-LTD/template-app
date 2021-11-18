// Author: Dean.Liu
// DateTime: 2021/08/26 10:49

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseListTile extends StatefulWidget {
  const BaseListTile({
    Key? key,
    this.child,
    this.enableHighlight = true,
    this.highlightColor = Colors.black12,
    this.enableScale = false,
    this.scale = 0.8,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  /// 子组件
  final Widget? child;

  /// 点击、长按时是否显示高亮颜色
  final bool enableHighlight;

  /// 高亮颜色
  final Color highlightColor;

  /// 点击、长按时是否开启缩放动画
  final bool enableScale;

  /// 缩放的比例
  final double scale;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  @override
  _BaseListTileState createState() => _BaseListTileState();
}

class _BaseListTileState extends State<BaseListTile>
    with SingleTickerProviderStateMixin {
  /// 根据点击状态，决定是否高亮显示
  var _isHighlighting = false;

  /// 缩放动画控制器
  AnimationController? _controller;

  /// 缩放动画当前 scale 值
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.enableScale) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
        value: 1,
        lowerBound: widget.scale,
      );
      _animation =
          CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _updateBackground(bool isHighlight) {
    setState(() {
      _isHighlighting = isHighlight;
    });
    if (isHighlight) {
      _controller?.reverse();
    } else {
      _controller?.forward();
    }
  }

  Widget _buildBackgroundView() {
    final background = DecoratedBox(
      decoration: BoxDecoration(
          color: (widget.enableHighlight && _isHighlighting)
              ? widget.highlightColor
              : null),
      child: widget.child,
    );
    if (widget.enableScale) {
      return ScaleTransition(
        scale: _animation,
        child: background,
      );
    } else {
      return background;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _updateBackground(true),
      onTapUp: (_) => _updateBackground(false),
      onTapCancel: () => _updateBackground(false),
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: _buildBackgroundView(),
    );
  }
}
