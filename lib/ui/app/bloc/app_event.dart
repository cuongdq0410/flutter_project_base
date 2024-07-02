part of 'app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.getLanguage() = _GetLanguage;

  const factory AppEvent.changeLanguage(Locale locale) = _ChangeLanguage;
}
