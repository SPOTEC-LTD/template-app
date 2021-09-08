// Author: Dean.Liu
// DateTime: 2021/09/02 10:09

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../base/base_stful_widget.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

/// 对 [BlocProvider] 的封装，减少组件层级
///
/// 项目配合 flutter_hooks 使用，应该不会用到该类，先定义在这以防万一
abstract class BlocStfulWidget extends BaseStfulWidget {
  const BlocStfulWidget({Key? key}) : super(key: key);

  @override
  BlocStfulWidgetState createState(); // ignore: no_logic_in_create_state
}

abstract class BlocStfulWidgetState<T extends BlocStfulWidget,
    B extends BlocBase<S>, S> extends BaseStfulWidgetState<T> {
  /// 生成页面的视图
  Widget buildView(BuildContext context, S state);

  /// 创建页面的 Bloc 或 Cubit
  B createBloc(BuildContext context);

  /// 对比前后前后状态，判断是否刷新控件
  bool buildWhen(S previous, S current) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: createBloc,
      child: BlocBuilder<B, S>(
        buildWhen: buildWhen,
        builder: (_, state) {
          return HookBuilder(builder: (context) {
            return buildView(context, state);
          });
        },
      ),
    );
  }
}
