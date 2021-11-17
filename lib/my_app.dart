import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_provider/theme_provider.dart';

import 'basic/router/f_router.dart';
import 'basic/utils/intl_util.dart';
import 'basic/utils/size_util.dart';
import 'basic/utils/theme_util.dart';
import 'business/home_page.dart';
import 'generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return ThemeProvider(
          saveThemesOnChange: true,
          loadThemeOnInit: false,
          onInitCallback: (controller, previouslySavedThemeFuture) async {
            final String? savedTheme = await previouslySavedThemeFuture;
            print('=====savedTheme}=$savedTheme====');
            if (savedTheme != null) {
              controller.setTheme(savedTheme);
            } else {
              controller.setTheme(CustomTheme.appDarkThemeId);
              controller.forgetSavedTheme();
            }
          },
          // 可用的主题
          themes: <AppTheme>[
            CustomTheme.appDarkTheme,
            CustomTheme.appLightTheme,
          ],
          child: ThemeConsumer(
            child: Builder(
              builder: (context) => MaterialApp(
                key: state.key,
                navigatorKey: FRouter.rootNavigatorKey,
                locale: IntlUtil.getCurrentLocale(),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                onGenerateRoute: FluroRouter.appRouter.generator,
                // 保存的主题
                theme: ThemeProvider.themeOf(context).data,
                home: const HomePage(),
                builder: EasyLoading.init(
                  builder: (context, child) {
                    // 必须在能拿到MediaQuery的context中配置
                    SizeUtil.setup(context);
                    return MediaQuery(
                      // 设置文字大小不随系统设置改变
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      // 全局范围注册点击事件，点击空白处隐藏键盘
                      child: GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: child,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
