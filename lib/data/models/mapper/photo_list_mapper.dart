import 'package:flutter_bloc_base/data/models/response/photos_response.dart';
import 'package:flutter_bloc_base/domain/entites/photo/photo_list.dart';

import 'model_item_mapper.dart';
import 'pagination_mapper.dart';
import 'photo_item_mapper.dart';

class PhotoListMapper extends ModelItemMapper<PhotosResponse, PhotoList> {
  @override
  PhotoList mapperTo(PhotosResponse? data) {
    return PhotoList(
      photos:
          data?.photos?.map((e) => PhotoItemMapper().mapperTo(e)).toList() ??
              [],
      pagination: PaginationMapper().mapperTo(data?.pagination),
    );
  }
}
