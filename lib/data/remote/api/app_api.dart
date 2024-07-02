import 'package:dio/dio.dart';
import 'package:flutter_bloc_base/data/models/request/login_request.dart';
import 'package:flutter_bloc_base/data/models/response/login_response.dart';
import 'package:flutter_bloc_base/data/models/response/photos_response.dart';
import 'package:flutter_bloc_base/data/models/response/version_info_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/response/api_base_response.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST("/login-v2")
  Future<ApiResponse<LoginResponse>> login(@Body() LoginRequest loginRequest);

  @GET('/version')
  Future<VersionInfoResponse> getAppVersion(@Query('platform') String platform);

  @GET('/search')
  Future<PhotosResponse> searchPhoto(
    @Query('query') String? query,
    @Query('per_page') int perPage,
    @Query('page') int page,
  );
}
