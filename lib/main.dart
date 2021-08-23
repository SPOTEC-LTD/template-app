import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'basic/router/f_router.dart';
import 'basic/utils/hud_util.dart';
import 'basic/utils/intl_util.dart';
import 'basic/utils/sp_util.dart';
import 'common/consts/service_urls.dart';
import 'my_app.dart';
import 'routes/f_router_setup.dart';

void main() {
  HudUtil.setup(backgroundColor: Colors.greenAccent);
  FRouter().setup(innerUrl);
  // 必须要添加这个进行初始化 否则SpUtil.setup()报错
  WidgetsFlutterBinding.ensureInitialized();
  // 确保后续步骤可以正常存取shared_preferences的数据
  SpUtil.setup().then((value) {
    // 各模块路由路径配置
    FRouter().configureRoutes();
    runApp(BlocProvider(
      create: (context) => LocaleCubit(),
      child: const MyApp(),
    ));
  });
}
