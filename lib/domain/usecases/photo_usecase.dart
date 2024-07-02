import 'package:flutter_bloc_base/domain/entites/photo/photo_list.dart';
import 'package:flutter_bloc_base/domain/repository/photo_repository.dart';

class PhotoUseCase {
  final PhotoRepository _repository;

  PhotoUseCase(this._repository);

  Future<PhotoList> searchPhoto({
    String? query,
    required int page,
  }) {
    return _repository.searchPhoto(
      query: query,
      page: page,
    );
  }
}
