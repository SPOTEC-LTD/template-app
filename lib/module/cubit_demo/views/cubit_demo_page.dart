import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/module/cubit_demo/cubits/cubit_demo_cubit.dart';
import 'package:template/module/cubit_demo/models/post_entity.dart';
import 'package:template/widgets/base/base_app_bar.dart';
import 'package:template/widgets/refresher/refresher.dart';

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
          child: _listView(state.posts),
          status: state.status,
          isListEmpty: state.posts.isEmpty,
          onRefresh: () async => cubit.refresh(),
        );
      }),
    );
  }

  Widget _listView(List<PostEntity> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _CubitListItem(title: '${posts[index].title}');
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
    return Container(
      child: Text(title),
      color: Colors.cyan,
      height: 60,
      alignment: Alignment.centerLeft,
    );
  }
}
