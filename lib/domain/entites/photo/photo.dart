import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required int id,
    required int photographerId,
    required String photographer,
    required String photographerUrl,
    required String originalSrcUrl,
    required int width,
    required int height,
    required bool liked,
  }) = _Photo;
}
