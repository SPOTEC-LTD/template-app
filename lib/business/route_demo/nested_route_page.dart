// Author: Dean.Liu
// DateTime: 2021/08/23 10:49

import 'package:flutter/material.dart';

import '../../basic/views/base/base_app_bar.dart';

class NestedRoutePage extends StatelessWidget {
  const NestedRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'NestedRoutePage'),
    );
  }
}
