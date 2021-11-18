// Author: Dean.Liu
// DateTime: 2021/09/03 00:16

import 'package:flutter/material.dart';

import '../../../basic/router/f_router.dart';
import '../../../basic/views/base/base_app_bar.dart';
import '../../../common/views/title_action_item.dart';
import 'bloc_stful_hook_page.dart';
import 'bloc_stless_hook_page.dart';
import 'native_hook_page.dart';

class HookHomePage extends StatefulWidget {
  const HookHomePage({Key? key}) : super(key: key);

  @override
  _HookHomePageState createState() => _HookHomePageState();
}

class _HookHomePageState extends State<HookHomePage> {
  void _pushNativeHookDemoPage(BuildContext context) {
    FRouter().pushPage(context, const NativeHookPage());
  }

  void _pushBlocStlessEasyHookPage(BuildContext context) {
    FRouter().pushPage(context, const BlocStleeHookPage());
  }

  void _pushBlocStfulHookPage(BuildContext context) {
    FRouter().pushPage(context, const BlocStfulHookPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleText: 'HookHomePage'),
      body: ListView(
        children: [
          TitleActionItem(
            title: 'Native Hook Page',
            onTap: () => _pushNativeHookDemoPage(context),
          ),
          TitleActionItem(
            title: 'Bloc Stateless Hook Page',
            onTap: () => _pushBlocStlessEasyHookPage(context),
          ),
          TitleActionItem(
            title: 'Bloc Stateful Hook Page',
            onTap: () => _pushBlocStfulHookPage(context),
          ),
        ],
      ),
    );
  }
}
