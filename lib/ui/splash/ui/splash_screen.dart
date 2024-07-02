import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/gen/assets.gen.dart';
import 'package:flutter_bloc_base/ui/base/base_screen.dart';
import 'package:flutter_bloc_base/ui/splash/bloc/splash_bloc.dart';
import 'package:flutter_bloc_base/ui/widget/notification_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../utils/dialog_utils.dart';
import '../../widget/route_define.dart';
import '../../widget/update_app_dialog.dart';

class SplashScreen extends BaseScreen {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen, SplashBloc> {
  @override
  afterBuild() {
    bloc.add(const SplashEvent.getVersion());
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        state.when(
          init: () {},
          authenticate: () {
            context.goNamed(RouteDefine.homeScreen.name);
          },
          unAuthenticate: () {
            context.goNamed(RouteDefine.loginScreen.name);
          },
          updateApp: (versionData) {
            UpdateAppDialog.showMyDialog(
              context: context,
              onSkip: () {
                Navigator.pop(context);
                versionData.onSkip();
              },
              isForceUpdate: versionData.isForceUpdate,
            );
          },
          retryGetVersion: (message) {
            retryGetAppVersionDialog(message);
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: Assets.logo.iconText.svg(
            width: 150,
          ),
        ),
      ),
    );
  }

  Future<dynamic> retryGetAppVersionDialog(String message) {
    return DialogUtils.showCustomDialog(
      barrierDismissible: false,
      NotificationDialog(
        title: 'Error',
        descriptionText: message,
        buttonText: "Retry",
        descriptionTextAlign: TextAlign.center,
        onClickButton: () {
          Navigator.pop(context);
          bloc.add(const SplashEvent.getVersion());
        },
      ),
    );
  }
}
