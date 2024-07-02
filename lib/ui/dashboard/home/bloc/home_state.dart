part of 'home_bloc.dart';

enum ListStatus { loading, success, failure }

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(ListStatus.loading) ListStatus listStatus,
    @Default(
      PhotoList(
        pagination: Pagination(
          page: 0,
          perPage: 0,
          totalResults: 0,
        ),
        photos: [],
      ),
    )
    PhotoList photos,
  }) = _HomeStateInit;
}
