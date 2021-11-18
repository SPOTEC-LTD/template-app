// Author: Dean.Liu
// DateTime: 2021/08/12 19:45

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import 'sp_util.dart';

/// 国际化相关
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
      : super(LocaleState(
          locale: IntlUtil.getCurrentLocale(),
          key: UniqueKey(),
        ));

  /// 切换语言并重建根视图
  void load(Locale locale) {
    if (locale != state.locale) {
      // 每次切换语言都返回新建的 key，强制 APP 重建
      emit(state.copyWith(locale: locale));
    }
  }
}

/// 国际化相关
class LocaleState {
  /// 当前 APP 的国际化标识对象
  final Locale locale;

  /// 根视图 MaterialApp 的 key
  final UniqueKey key;

  LocaleState({
    required this.locale,
    required this.key,
  });

  LocaleState copyWith({required Locale locale}) {
    return LocaleState(
      key: UniqueKey(),
      locale: locale,
    );
  }
}

/// 国际化相关工具类
class IntlUtil {
  static const _languageCodeKey = 'languageCodeKey';

  /// 返回语言编码 + 国家编码
  static String getFullLocaleCode(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.countryCode == null) {
      return locale.languageCode;
    } else {
      return '${locale.languageCode}_${locale.countryCode!}';
    }
  }

  /// 返回当前的国际化 Locale 对象
  static Locale getCurrentLocale() {
    final preferLanguageCode = SpUtil.getString(_languageCodeKey);
    var languageCode = Intl.getCurrentLocale();
    if (preferLanguageCode != null) {
      languageCode = preferLanguageCode;
    }
    return Locale(languageCode);
  }

  /// 设置当前国际化 Locale 对象
  static void setLocal(BuildContext context, Locale locale) {
    S.load(locale);
    SpUtil.putString(_languageCodeKey, locale.languageCode)?.then((value) {
      context.read<LocaleCubit>().load(locale);
    });
  }
}
