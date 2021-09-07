// Author: Dean.Liu
// DateTime: 2021/09/03 00:07

import 'package:flutter/material.dart';

import '../../../basic/hooks/refresh_hook.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../basic/views/base/base_button.dart';
import '../../../basic/views/bloc/bloc_stful_widget.dart';
import '../../../basic/views/refresher/refresher.dart';
import '../../../common/views/title_action_item.dart';
import '../blocs/easy_hook_cubit.dart';

class BlocStfulHookPage extends BlocStfulWidget {
  const BlocStfulHookPage({Key? key}) : super(key: key);

  @override
  _BlocStfulHookPageState createState() => _BlocStfulHookPageState();
}

class _BlocStfulHookPageState extends BlocStfulWidgetState<BlocStfulHookPage,
    EasyHookCubit, EasyHookState> {
  @override
  EasyHookCubit createBloc(BuildContext context) {
    return EasyHookCubit();
  }

  var isSelected = false;

  @override
  Widget buildView(BuildContext context, EasyHookState state) {
    final cubit = context.read<EasyHookCubit>();
    final refreshHook = useRefreshHook(request: cubit.requestPsots);
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'BlocStfulHookPage',
        actions: [
          BaseButton(
            text: isSelected ? 'selected' : 'unselected',
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                isSelected = !isSelected;
              });
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
