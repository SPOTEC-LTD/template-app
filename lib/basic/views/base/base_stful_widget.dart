// Author: Dean.Liu
// DateTime: 2021/09/01 18:01

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class BaseStfulWidget extends StatefulHookWidget {
  const BaseStfulWidget({Key? key}) : super(key: key);
}

abstract class BaseStfulWidgetState<T extends BaseStfulWidget>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }
}
