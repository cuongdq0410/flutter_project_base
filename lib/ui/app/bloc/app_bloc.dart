import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_base/data/storage/session_utils.dart';
import 'package:flutter_bloc_base/generated/l10n.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.dart';

part 'app_state.dart';

part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.init()) {
    on<_ChangeLanguage>(_changeLanguage);
    on<_GetLanguage>(_getLanguage);
  }

  Future<void> _getLanguage(_GetLanguage event, Emitter<AppState> emit) async {
    final locale = SessionUtils.getLocale();
    if (locale == null) return;
    emit(state.copyWith(locale: locale));
  }

  Future<void> _changeLanguage(
      _ChangeLanguage event, Emitter<AppState> emit) async {
    if (event.locale.languageCode == state.locale.languageCode) return;
    SessionUtils.saveLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }

  List<Locale> get supportedLanguages => const [
        Locale('en'),
        Locale('vi'),
      ];

  String getLanguageName(BuildContext context, Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return S.of(context).english;
      case 'vi':
        return S.of(context).vietnamese;
      default:
        return S.of(context).english;
    }
  }
}
