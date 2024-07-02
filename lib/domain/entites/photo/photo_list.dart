import 'package:flutter_bloc_base/domain/entites/pagination/pagination.dart';
import 'package:flutter_bloc_base/domain/entites/photo/photo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_list.freezed.dart';

@freezed
class PhotoList with _$PhotoList {
  const factory PhotoList({
    required Pagination pagination,
    required List<Photo> photos,
  }) = _PhotoList;
}
