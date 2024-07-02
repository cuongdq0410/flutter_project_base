import 'package:flutter_bloc_base/data/models/request/login_request.dart';
import 'package:flutter_bloc_base/data/models/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse?> login(LoginRequest request);
}
