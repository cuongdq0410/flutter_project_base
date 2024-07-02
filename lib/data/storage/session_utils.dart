import 'dart:ui';

import 'package:flutter_bloc_base/injection/injector.dart';

import 'shared_pref_manager.dart';

class SessionUtils {
  static void saveAccessToken(String accessToken) =>
      injector.get<SharedPreferencesManager>().putString(
            SharedPreferenceKey.keyAccessToken,
            accessToken,
          );

  static String getAccessToken() =>
      injector<SharedPreferencesManager>()
          .getString(SharedPreferenceKey.keyAccessToken) ??
      '';

  static Future<void> clearSession() async {
    await injector<SharedPreferencesManager>()
        .removeByKey(SharedPreferenceKey.keyAccessToken);
    await injector<SharedPreferencesManager>()
        .removeByKey(SharedPreferenceKey.keyRefreshToken);
  }

  static void saveRefreshToken(String accessToken) =>
      injector<SharedPreferencesManager>().putString(
        SharedPreferenceKey.keyRefreshToken,
        accessToken,
      );

  static String getRefreshToken() =>
      injector<SharedPreferencesManager>()
          .getString(SharedPreferenceKey.keyRefreshToken) ??
      '';

  static void saveLocale(Locale locale) =>
      injector.get<SharedPreferencesManager>().putString(
            SharedPreferenceKey.keyLocale,
            locale.languageCode,
          );

  static Locale? getLocale() {
    final String? langCode = injector<SharedPreferencesManager>()
        .getString(SharedPreferenceKey.keyLocale);
    if (langCode != null) {
      return Locale(langCode);
    }
    return null;
  }
}
