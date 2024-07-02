import 'package:flutter_bloc_base/domain/entites/photo/photo_list.dart';

abstract class PhotoRepository {
  Future<PhotoList> searchPhoto({
    String? query,
    required int page,
  });
}
