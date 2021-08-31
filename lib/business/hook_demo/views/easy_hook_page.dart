// Author: Dean.Liu
// DateTime: 2021/08/31 18:35

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../basic/views/base/base_app_bar.dart';
import '../blocs/easy_hook_cubit.dart';

abstract class BaseStlessPage extends StatelessWidget {
  const BaseStlessPage({
    Key? key,
    required this.cubit,
    // required this.child,
  }) : super(key: key);

  final Cubit<Object> cubit;
  // final Widget child;

  Widget buildView();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: buildView(),
    );
  }
}

class EasyHookPage extends BaseStlessPage {
  EasyHookPage({Key? key}) : super(key: key, cubit: EasyHookCubit());

  @override
  Widget buildView() {
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Easy Hook Page',
      ),
    );
  }
}
