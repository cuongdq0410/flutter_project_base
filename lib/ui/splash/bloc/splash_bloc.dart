import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_base/data/storage/session_utils.dart';
import 'package:flutter_bloc_base/domain/usecases/user_usecase.dart';
import 'package:flutter_bloc_base/ui/splash/models/app_version_data.dart';
import 'package:flutter_bloc_base/ui/utils/device_info_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_bloc.freezed.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserUseCase _userUseCase;

  SplashBloc(this._userUseCase) : super(const SplashState.init()) {
    on<_GetVersion>((event, emit) async {
      try {
        final response = await _userUseCase.getAppVersion();
        final localVersion = await DeviceInfoUtil.getAppVersion();
        String remoteVersion = response.version ?? '1.0.0';
        if (!(await DeviceInfoUtil.isAppOutdated(remoteVersion))) {
          add(const _CheckAuthenticateStatus());
        } else {
          emit(
            SplashState.updateApp(
              versionData: AppVersionData(
                localVersion,
                remoteVersion,
                false,
                () {
                  add(const _CheckAuthenticateStatus());
                },
              ),
            ),
          );
        }
      } on Exception catch (ex) {
        emit(
          SplashState.retryGetVersion(messageError: ex.toString()),
        );
      }
    });
    on<_CheckAuthenticateStatus>(checkLoginStatus);
  }

  checkLoginStatus(
      _CheckAuthenticateStatus event, Emitter<SplashState> emit) async {
    final token = SessionUtils.getAccessToken();
    if (token.isEmpty) {
      emit(const SplashState.unAuthenticate());
    } else {
      emit(const SplashState.authenticate());
    }
  }
}
