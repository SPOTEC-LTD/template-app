import 'package:flutter_bloc/flutter_bloc.dart';

import 'refresh_status.dart';

abstract class Refreshable {
  /// 当前刷新状态
  late RefreshStatus refreshStatus;

  /// 列表是否为空
  bool get isListEmpty;

  /// 是否还有更多数据可以加载
  late bool noMore;
}

abstract class RefreshableCubit<State> extends Cubit<State> {
  RefreshableCubit(State initialState) : super(initialState);

  void refresh();
  void loadMore();
}
