import 'package:freezed_annotation/freezed_annotation.dart';

part 'photos_response.freezed.dart';
part 'photos_response.g.dart';

@freezed
class PhotosResponse with _$PhotosResponse {
  const factory PhotosResponse({
    @JsonKey(readValue: readRootValue) PaginationResponse? pagination,
    @JsonKey(name: 'photos') List<PhotoItemResponse>? photos,
  }) = _PhotosResponse;

  factory PhotosResponse.fromJson(Map<String, Object?> json) =>
      _$PhotosResponseFromJson(json);
}

@freezed
class PhotoItemResponse with _$PhotoItemResponse {
  const factory PhotoItemResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'width') int? width,
    @JsonKey(name: 'height') int? height,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'photographer') String? photographer,
    @JsonKey(name: 'photographer_url') String? photographerUrl,
    @JsonKey(name: 'photographer_id') int? photographerId,
    @JsonKey(name: 'avg_color') String? avgColor,
    @JsonKey(name: 'src') PhotoSrcResponse? src,
    @JsonKey(name: 'liked') bool? liked,
    @JsonKey(name: 'alt') String? alt,
  }) = _PhotoItemResponse;

  factory PhotoItemResponse.fromJson(Map<String, Object?> json) =>
      _$PhotoItemResponseFromJson(json);
}

@freezed
class PhotoSrcResponse with _$PhotoSrcResponse {
  const factory PhotoSrcResponse({
    @JsonKey(name: 'original') String? original,
    @JsonKey(name: 'large2x') String? large2x,
    @JsonKey(name: 'large') String? large,
    @JsonKey(name: 'medium') String? medium,
    @JsonKey(name: 'small') String? small,
    @JsonKey(name: 'portrait') String? portrait,
    @JsonKey(name: 'landscape') String? landscape,
    @JsonKey(name: 'tiny') String? tiny,
  }) = _PhotoSrcResponse;

  factory PhotoSrcResponse.fromJson(Map<String, Object?> json) =>
      _$PhotoSrcResponseFromJson(json);
}

@freezed
class PaginationResponse with _$PaginationResponse {
  const factory PaginationResponse({
    @JsonKey(name: 'total_results') int? totalResults,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'next_page') String? nextPage,
  }) = _PaginationResponse;

  factory PaginationResponse.fromJson(Map<String, Object?> json) =>
      _$PaginationResponseFromJson(json);
}

Map<String, dynamic> readRootValue(Map<dynamic, dynamic> json, String key) {
  if (json is Map<String, dynamic>) {
    return json;
  }
  return {};
}
