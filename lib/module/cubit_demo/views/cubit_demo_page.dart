import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/module/cubit_demo/cubits/cubit_demo_cubit.dart';
import 'package:template/module/cubit_demo/models/post_entity.dart';
import 'package:template/widgets/refresher/refresher.dart';

class CubitDemoPage extends StatelessWidget {
  const CubitDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitDemoCubit(),
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
      appBar: AppBar(
        title: Text('Cubit'),
      ),
      body: BlocBuilder<CubitDemoCubit, CubitDemoState>(
          builder: (context, state) {
        return Refresher(
          controller: _refreshController,
          onRefresh: () async => cubit.refresh(),
          child: () {
            switch (state.status) {
              case PostStatus.initial:
                return _loadingView();
              case PostStatus.failure:
                _refreshController.finishRefresh(success: false);
                return _failureView();
              case PostStatus.success:
                _refreshController.finishRefresh(
                    success: state.posts.isNotEmpty);
                if (state.posts.isEmpty) {
                  return _emptyView();
                } else {
                  return _listView(state.posts);
                }
            }
          }(),
        );
      }),
    );
  }

  Widget _loadingView() {
    return Center(
      child: Text('loading...'),
    );
  }

  Widget _failureView() {
    return Center(
      child: Text('request failure...'),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Text('no data'),
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
