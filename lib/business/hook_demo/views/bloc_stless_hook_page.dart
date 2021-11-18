// Author: Dean.Liu
// DateTime: 2021/08/31 18:35

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../basic/hooks/load_more_entity.dart';
import '../../../basic/hooks/load_more_hook.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../basic/views/base/base_button.dart';
import '../../../basic/views/bloc/bloc_stless_widget.dart';
import '../../../basic/views/refresher/hook_refresher.dart';
import '../../../common/views/title_action_item.dart';
import '../../cubit_demo/models/post_entity.dart';
import '../blocs/easy_hook_cubit.dart';

class BlocStleeHookPage extends BlocStlessWidget<EasyHookCubit, EasyHookState> {
  const BlocStleeHookPage({Key? key}) : super(key: key);

  @override
  EasyHookCubit createBloc(BuildContext context) {
    return EasyHookCubit();
  }

  Widget _buildActions(
      LoadMoreHookEntity<PostEntity> loadMoreHook, EasyHookState state) {
    return Row(
      children: [
        BaseButton(
          text: 'Clear',
          textColor: Colors.white,
          color: Colors.cyan,
          onPressed: () {
            loadMoreHook.entities.value = [];
          },
        ),
        BaseButton(
          text: 'Refresh',
          textColor: Colors.white,
          color: Colors.cyan,
          onPressed: () {
            loadMoreHook.controller.callRefresh();
          },
        ),
      ],
    );
  }

  @override
  Widget buildView(BuildContext context, EasyHookState state) {
    final cubit = context.read<EasyHookCubit>();
    final loadMoreHook = useLoadMoreHook(request: cubit.requestPsots);
    return Scaffold(
      appBar: BaseAppBar(titleText: 'BlocStlessHookPage'),
      body: Column(
        children: [
          _buildActions(loadMoreHook, state),
          Expanded(
            child: HookRefresher(
              refreshHook: loadMoreHook,
              child: ListView.builder(
                itemCount: loadMoreHook.entities.value.length,
                itemBuilder: (context, index) {
                  return TitleActionItem(
                      title: loadMoreHook.entities.value[index].title);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
