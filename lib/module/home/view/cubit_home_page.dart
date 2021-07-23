import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/module/home/cubit/home_cubit.dart';
import 'package:template/widgets/refresher/refresher.dart';

class CubitHomePage extends StatelessWidget {
  const CubitHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: CubitHomeView(),
    );
  }
}

class CubitHomeView extends StatelessWidget {
  final _refreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit'),
      ),
      body: Refresher(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _CubitListItem(title: 'title');
          },
        ),
        controller: _refreshController,
      ),
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
