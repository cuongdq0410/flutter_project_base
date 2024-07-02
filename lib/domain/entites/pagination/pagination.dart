import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    required int page,
    required int perPage,
    required int totalResults,
  }) = _Pagination;
}
