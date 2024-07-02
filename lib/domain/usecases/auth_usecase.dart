import 'package:flutter_bloc_base/domain/repository/auth_repository.dart';

import '../../data/models/request/login_request.dart';
import '../../data/models/response/login_response.dart';

class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Future<LoginResponse?> login(LoginRequest request) {
    return _repository.login(request);
  }
}
