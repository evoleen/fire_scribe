import 'dart:ui';

import 'package:firearrow_admin_app/app_logger.dart';
import 'package:firearrow_admin_app/l10n/supported_locales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_cubit.freezed.dart';

@freezed
class LocalizationCubitState with _$LocalizationCubitState {
  const factory LocalizationCubitState.initial() = _Initial;
  const factory LocalizationCubitState.locale({
    required final Locale locale,
  }) = _Locale;
}

class LocalizationCubit extends Cubit<LocalizationCubitState> {
  static const String keyLanguageCode = 'AppLocalizationsDelegate#languageCode';
  static const String keyCountryCode = 'AppLocalizationsDelegate#countryCode';

  final SharedPreferences sharedPreferences;

  LocalizationCubit({
    required this.sharedPreferences,
  }) : super(const LocalizationCubitState.initial()) {
    initialize();
  }

  Future<void> initialize() async {
    if (!sharedPreferences.containsKey(keyLanguageCode)) {
      final defaultLocale = supportedLocales.first;
      await sharedPreferences.setString(
          keyLanguageCode, defaultLocale.languageCode);
      await sharedPreferences.setString(
          keyCountryCode, defaultLocale.countryCode!);
    }

    final locale = Locale(
      sharedPreferences.getString(keyLanguageCode)!,
      sharedPreferences.getString(keyCountryCode),
    );

    if (!supportedLocales.contains(locale)) {
      throw Exception('supportedLocales must contain locale $locale');
    }

    final newLocale = supportedLocales.firstWhere((final e) => e == locale);
    emit(_Locale(locale: newLocale));
    AppLogger.instance.d('LocaleManager, set current locale $newLocale');
  }

  Future<void> changeLocale({required final Locale locale}) async {
    await sharedPreferences.setString(keyLanguageCode, locale.languageCode);
    await sharedPreferences.setString(keyCountryCode, locale.countryCode!);
    emit(_Locale(locale: locale));
    AppLogger.instance.d('LocaleManager, change locale to $locale');
  }
}
