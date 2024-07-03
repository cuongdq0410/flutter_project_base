import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_base/data/models/request/login_request.dart';
import 'package:flutter_bloc_base/ui/base/cubit_mixin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecases/auth_usecase.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with BlocMixin {
  final AuthUseCase _authUseCase;

  LoginBloc(this._authUseCase) : super(const LoginState.init()) {
    on<_Login>(login);
  }

  Future<void> login(_Login event, Emitter<LoginState> emit) async {
    setLoading();
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      await _authUseCase.login(
        LoginRequest(
          email: event.email,
          password: event.password,
        ),
      );
      hideLoading();
      emit(const LoginState.loginSuccess());
    } on Exception catch (error) {
      hideLoading();
      setThrowable(error);
    }
  }
}
