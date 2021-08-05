import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/business/cubit_demo/cubits/cubit_demo_cubit.dart';
import 'package:template/business/cubit_demo/models/post_entity.dart';
import 'package:template/basic/views/base/base_app_bar.dart';
import 'package:template/basic/views/refresher/refresher.dart';

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

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CubitDemoCubit>();
    return Scaffold(
      appBar: BaseAppBar(
        titleText: 'Cubit Demo',
      ),
      body: BlocBuilder<CubitDemoCubit, CubitDemoState>(
          builder: (context, state) {
        return Refresher(
          controller: _refreshController,
          child: _buildListView(state.posts),
          status: state.refreshStatus,
          isListEmpty: state.posts.isEmpty,
          noMore: state.noMore,
          onRefresh: () async => cubit.refresh(),
          onLoad: () async => cubit.loadMore(),
        );
      }),
    );
  }

  Widget _buildListView(List<PostEntity> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _CubitListItem(title: posts[index].title);
      },
    );
  }
}

class _CubitListItem extends StatelessWidget {
  final String title;

  const _CubitListItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(title),
          height: 60,
          alignment: Alignment.centerLeft,
        ),
        const Divider(),
      ],
    );
  }
}
