import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import 'sp_util.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
      : super(LocaleState(
          locale: IntlUtil.getLocale(),
          key: UniqueKey(),
        ));

  void load(Locale locale) {
    if (locale != state.locale) {
      // 每次切换语言都返回新建的key，强制APP重建
      emit(state.copyWith(locale: locale, key: UniqueKey()));
    }
  }
}

class LocaleState {
  final Locale locale;
  final UniqueKey key;

  LocaleState({
    required this.locale,
    required this.key,
  });

  LocaleState copyWith({required Locale locale, required UniqueKey key}) {
    return LocaleState(
      key: key,
      locale: locale,
    );
  }
}

class IntlUtil {
  static const _languageCodeKey = 'languageCodeKey';

  static String getFullLocaleCode(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.countryCode == null) {
      return locale.languageCode;
    } else {
      return '${locale.languageCode}_${locale.countryCode!}';
    }
  }

  static Locale getLocale() {
    final preferLanguageCode = SpUtil.getString(_languageCodeKey);
    var languageCode = Intl.getCurrentLocale();
    if (preferLanguageCode != null) {
      languageCode = preferLanguageCode;
    }
    return Locale(languageCode);
  }

  static void setLocal(BuildContext context, Locale locale) {
    S.load(locale);
    SpUtil.putString(_languageCodeKey, locale.languageCode)?.then((value) {
      context.read<LocaleCubit>().load(locale);
    });
  }
}
