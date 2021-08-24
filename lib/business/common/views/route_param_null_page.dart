// Author: Dean.Liu
// DateTime: 2021/08/24 16:26

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../basic/views/base/base_app_bar.dart';

class RouteParamNullPage extends StatelessWidget {
  const RouteParamNullPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'RouteParamNullPage'),
      body: const Center(
        child: Text('Please Check Param'),
      ),
    );
  }
}
