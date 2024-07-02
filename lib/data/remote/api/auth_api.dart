import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/request/refresh_token_request.dart';
import '../../models/response/login_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dioBuilder) = _AuthApi;

  @POST("/oauth/token")
  Future<LoginResponse> refreshToken(@Body() RefreshTokenRequest request);
}
