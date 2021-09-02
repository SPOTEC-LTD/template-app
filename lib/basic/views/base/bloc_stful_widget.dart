// Author: Dean.Liu
// DateTime: 2021/09/02 10:09

import 'package:flutter/cupertino.dart';

import 'base_stful_widget.dart';

abstract class BlocStfulWidget extends BaseStfulWidget {
  const BlocStfulWidget({Key? key}) : super(key: key);

  @override
  BlocStfulWidgetState createState(); // ignore: no_logic_in_create_state
}

abstract class BlocStfulWidgetState<T extends BlocStfulWidget>
    extends BaseStfulWidgetState<T> {}
