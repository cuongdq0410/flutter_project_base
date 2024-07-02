part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.init([@Default(Locale('en', '')) Locale locale]) =
      AppStateInit;
}
