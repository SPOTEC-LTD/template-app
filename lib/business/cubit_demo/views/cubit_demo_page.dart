import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../basic/views/base/base_app_bar.dart';
import '../../../basic/views/refresher/refresher.dart';
import '../../../common/views/title_action_item.dart';
import '../cubits/cubit_demo_cubit.dart';
import '../models/post_entity.dart';

class CubitDemoPage extends StatelessWidget {
  const CubitDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitDemoCubit()..refresh(),
      child: CubitDemoView(),
    );
  }
}

class CubitDemoView extends StatelessWidget {
  final _refreshController = EasyRefreshController();

  CubitDemoView({Key? key}) : super(key: key);

  Widget _buildListView(List<PostEntity> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return TitleActionItem(title: posts[index].title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CubitDemoCubit>();
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Cubit Demo',
      ),
      body: BlocBuilder<CubitDemoCubit, CubitDemoState>(
          builder: (context, state) {
        return Refresher(
          controller: _refreshController,
          status: state.refreshStatus,
          isListEmpty: state.posts.isEmpty,
          noMore: state.noMore,
          onRefresh: () async => cubit.refresh(),
          onLoad: () async => cubit.loadMore(),
          child: _buildListView(state.posts),
        );
      }),
    );
  }
}
