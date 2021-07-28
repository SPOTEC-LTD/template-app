import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:template/basic/utils/intl_util.dart';
import 'package:template/basic/utils/sp_util.dart';
import 'package:template/routes/f_router.dart';
import 'package:template/routes/f_router_setup.dart';

import 'generated/l10n.dart';
import 'modules/home_page.dart';

void main() {
  FRouter().setup();
  // 必须要添加这个进行初始化 否则SpUtil().setup()报错
  WidgetsFlutterBinding.ensureInitialized();
  SpUtil().setup().then((value) {
    runApp(BlocProvider(
      create: (context) => LocaleCubit(),
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          key: state.key,
          locale: IntlUtil.getLocale(),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          onGenerateRoute: FluroRouter.appRouter.generator,
          home: HomePage(),
        );
      },
    );
  }
}
