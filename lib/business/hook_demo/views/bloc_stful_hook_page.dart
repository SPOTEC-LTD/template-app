// Author: Dean.Liu
// DateTime: 2021/09/03 00:07

import 'package:flutter/material.dart';

import '../../../basic/hooks/load_more_hook.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../basic/views/base/base_button.dart';
import '../../../basic/views/bloc/bloc_stful_widget.dart';
import '../../../basic/views/refresher/hook_refresher.dart';
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
    final loadMoreHook = useLoadMoreHook(request: cubit.requestPsots);
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
      body: HookRefresher(
        refreshHook: loadMoreHook,
        child: ListView.builder(
          itemCount: loadMoreHook.entities.value.length,
          itemBuilder: (context, index) {
            return TitleActionItem(
                title: loadMoreHook.entities.value[index].title);
          },
        ),
      ),
    );
  }
}
