import 'package:flutter/material.dart';

/// 弹窗队列管理
class DialogQueueManager {
  static bool _isNewQueue = true;
  static List<VoidCallback> _array = [];

  /// 入队
  static void enqueue(VoidCallback callback) {
    if (_isNewQueue) {
      _isNewQueue = false;
      callback();
    } else {
      _array.add(callback);
    }
  }

  /// 出队，返回出队是否成功
  static bool dequeue() {
    if (_array.isEmpty) {
      _isNewQueue = true;
      return false;
    } else {
      // 执行
      _array.first();
      // 删除
      _array.removeAt(0);
      _isNewQueue = _array.isEmpty;
      return true;
    }
  }

  static void clear() {
    _array = [];
    _isNewQueue = true;
  }
}
