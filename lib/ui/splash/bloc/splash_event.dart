part of 'splash_bloc.dart';

@freezed
class SplashEvent with _$SplashEvent {
  const factory SplashEvent.getVersion() = _GetVersion;

  const factory SplashEvent.checkAuthenticateStatus() =
      _CheckAuthenticateStatus;
}
