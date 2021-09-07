// Author: Dean.Liu
// DateTime: 2021/08/31 18:35

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../basic/hooks/refresh_hook.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../basic/views/base/base_button.dart';
import '../../../basic/views/bloc/bloc_stless_widget.dart';
import '../../../basic/views/refresher/refresher.dart';
import '../../../common/views/title_action_item.dart';
import '../blocs/easy_hook_cubit.dart';

class BlocStleeHookPage extends BlocStlessWidget<EasyHookCubit, EasyHookState> {
  const BlocStleeHookPage({Key? key}) : super(key: key);

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
        titleText: 'BlocStlessHookPage',
        actions: [
          BaseButton(
            text: 'Clear',
            textColor: Colors.white,
            onPressed: () {
              refreshHook.values.value = [];
            },
          ),
        ],
      ),
      body: Refresher(
        controller: refreshHook.controller,
        status: refreshHook.status,
        isListEmpty: refreshHook.values.value.isEmpty,
        noMore: refreshHook.noMore,
        onRefresh: () async => refreshHook.refresh(),
        onLoad: () async => refreshHook.loadMore(),
        child: ListView.builder(
          itemCount: refreshHook.values.value.length,
          itemBuilder: (context, index) {
            return TitleActionItem(
                title: refreshHook.values.value[index].title);
          },
        ),
      ),
    );
  }
}
