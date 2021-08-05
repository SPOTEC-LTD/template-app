import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:template/basic/utils/hud_util.dart';
import 'package:template/basic/utils/intl_util.dart';
import 'package:template/basic/utils/sp_util.dart';
import 'package:template/basic/utils/toast_util.dart';
import 'package:template/basic/router/f_router.dart';
import 'package:template/routes/f_router_setup.dart';

import 'business/consts/service_urls.dart';
import 'generated/l10n.dart';
import 'modules/home_page.dart';

void main() {
  HudUtil.setup(backgroundColor: Colors.greenAccent);
  // 基础组件的配置
  FRouter().setup(innerUrl);
  // 通用组件的配置
  FRouter().configureRoutes();
  // 必须要添加这个进行初始化 否则SpUtil().setup()报错
  WidgetsFlutterBinding.ensureInitialized();
  SpUtil().setup().then((value) {
    runApp(BlocProvider(
      create: (context) => LocaleCubit(),
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          key: state.key,
          navigatorKey: FRouter.rootNavigatorKey,
          locale: IntlUtil.getLocale(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          onGenerateRoute: FluroRouter.appRouter.generator,
          home: const HomePage(),
          builder: EasyLoading.init(builder: (context, child) {
            return MediaQuery(
              // 设置文字大小不随系统设置改变
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              // 全局范围注册点击事件，点击空白处隐藏键盘
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: child,
              ),
            );
          }),
        );
      },
    );
  }
}
