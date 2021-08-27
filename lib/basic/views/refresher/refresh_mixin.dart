import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'refresh_status.dart';

abstract class RefreshableMixin {
  /// 当前刷新状态
  RefreshStatus refreshStatus = RefreshStatus.initial;

  /// 列表是否为空
  bool get isListEmpty;

  /// 是否还有更多数据可以加载
  bool noMore = false;
}

abstract class RefreshableCubit extends Cubit<State> {
  RefreshableCubit(State initialState) : super(initialState);

  void refresh();
  void loadmore();
}
