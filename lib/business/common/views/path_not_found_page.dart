// Author: Dean.Liu
// DateTime: 2021/08/24 16:24

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../basic/views/base/base_app_bar.dart';

class PathNotFoundPage extends StatelessWidget {
  const PathNotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'PathNotFoundPage'),
      body: const Center(
        child: Text('Please Check Path'),
      ),
    );
  }
}
