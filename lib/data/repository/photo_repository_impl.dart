import 'package:flutter_bloc_base/data/app_error.dart';
import 'package:flutter_bloc_base/data/models/mapper/photo_list_mapper.dart';
import 'package:flutter_bloc_base/data/remote/api/app_api.dart';
import 'package:flutter_bloc_base/data/remote/exception_mapper.dart';
import 'package:flutter_bloc_base/domain/entites/photo/photo_list.dart';
import 'package:flutter_bloc_base/domain/repository/photo_repository.dart';
import 'package:flutter_bloc_base/injection/injector.dart';

class PhotoRepositoryImpl extends PhotoRepository {
  static final AppApi api = injector<AppApi>();

  @override
  Future<PhotoList> searchPhoto({String? query, required int page}) async {
    final data = await api
        .searchPhoto(query, 10, page)
        .catchError((error, stackTrace) async {
      throw await injector
          .get<ExceptionMapper>()
          .mapperTo(AppError.from(error as Exception));
    });
    return PhotoListMapper().mapperTo(data);
  }
}
