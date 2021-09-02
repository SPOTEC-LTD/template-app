// Author: Dean.Liu
// DateTime: 2021/09/01 18:53

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'base_stless_widget.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocStlessWidget<B extends BlocBase<S>, S>
    extends BaseStlessWidget {
  const BlocStlessWidget({Key? key}) : super(key: key);

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
