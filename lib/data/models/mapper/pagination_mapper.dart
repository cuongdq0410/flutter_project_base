import 'package:flutter_bloc_base/data/models/response/photos_response.dart';
import 'package:flutter_bloc_base/domain/entites/pagination/pagination.dart';

import 'model_item_mapper.dart';

class PaginationMapper extends ModelItemMapper<PaginationResponse, Pagination> {
  @override
  Pagination mapperTo(PaginationResponse? data) {
    return Pagination(
      page: data?.page ?? 0,
      totalResults: data?.totalResults ?? 0,
      perPage: data?.perPage ?? 0,
    );
  }
}
