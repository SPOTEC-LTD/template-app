// Author: Dean.Liu
// DateTime: 2021/08/31 18:35

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../basic/hooks/refresh_hook.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../basic/views/base/bloc_stless_widget.dart';
import '../../../basic/views/refresher/refresher.dart';
import '../../../common/views/title_action_item.dart';
import '../blocs/easy_hook_cubit.dart';

class EasyHookPage extends BlocStlessWidget<EasyHookCubit, EasyHookState> {
  const EasyHookPage({Key? key}) : super(key: key);

  @override
  EasyHookCubit createBloc(BuildContext context) {
    return EasyHookCubit();
  }

  @override
  Widget buildView(BuildContext context, EasyHookState state) {
    final cubit = context.read<EasyHookCubit>();
    final refreshHook = useRefreshHook(request: cubit.requestPsots);
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Easy Hook Page',
      ),
      body: Refresher(
        controller: refreshHook.controller,
        status: refreshHook.status,
        isListEmpty: refreshHook.values.isEmpty,
        noMore: refreshHook.noMore,
        onRefresh: () async => refreshHook.refresh(),
        onLoad: () async => refreshHook.loadMore(),
        child: ListView.builder(
          itemCount: refreshHook.values.length,
          itemBuilder: (context, index) {
            return TitleActionItem(title: refreshHook.values[index].title);
          },
        ),
      ),
    );
  }
}
