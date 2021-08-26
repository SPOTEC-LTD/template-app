// Author: Dean.Liu
// DateTime: 2021/08/26 10:49

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseListTile extends StatefulWidget {
  const BaseListTile({
    Key? key,
    this.child,
    this.highlightColor = Colors.black12,
    this.autoZoom = true,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  /// 子组件
  final Widget? child;

  /// 高亮颜色
  final Color highlightColor;

  /// 点击、长按时是否自动缩放
  final bool autoZoom;

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
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      value: 1,
      lowerBound: 0.8,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateHighlightState(bool isHighlight) {
    setState(() {
      _isHighlighting = isHighlight;
    });
    if (isHighlight) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  Widget _buildBackgroundView() {
    final background = DecoratedBox(
      decoration:
          BoxDecoration(color: _isHighlighting ? widget.highlightColor : null),
      child: widget.child,
    );
    if (widget.autoZoom) {
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
      onTapDown: (_) => _updateHighlightState(true),
      onTapUp: (_) => _updateHighlightState(false),
      onTapCancel: () => _updateHighlightState(false),
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: _buildBackgroundView(),
    );
  }
}
