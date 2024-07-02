import 'package:flutter_bloc_base/data/models/response/photos_response.dart';
import 'package:flutter_bloc_base/domain/entites/photo/photo.dart';

import 'model_item_mapper.dart';

class PhotoItemMapper extends ModelItemMapper<PhotoItemResponse, Photo> {
  @override
  Photo mapperTo(PhotoItemResponse? data) {
    return Photo(
      id: data?.id ?? -1,
      width: data?.width ?? 0,
      height: data?.height ?? 0,
      photographerId: data?.photographerId ?? -1,
      photographer: data?.photographer ?? '',
      photographerUrl: data?.photographerUrl ?? '',
      liked: data?.liked ?? false,
      originalSrcUrl: data?.src?.original ?? '',
    );
  }
}
