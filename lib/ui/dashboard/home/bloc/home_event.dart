part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.getPhoto({
    @Default(true) bool isRefresh,
    @Default('Vietnam Beautiful Landscape') String query,
  }) = _GetPhoto;
}
