import 'package:flutter/material.dart';
import 'package:flutter_bloc_base/gen/colors.gen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommonRefresher extends StatelessWidget {
  final RefreshController controller;
  final Widget child;
  final bool enablePullDown;
  final bool enablePullUp;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final Widget? loadingIcon;

  const CommonRefresher({
    Key? key,
    required this.controller,
    required this.child,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.onRefresh,
    this.onLoading,
    this.loadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      onRefresh: onRefresh,
      onLoading: onLoading,
      header: const WaterDropHeader(
        complete: SizedBox(),
        failed: SizedBox(),
        refresh: CircularProgressIndicator(color: ColorName.primaryColor),
        waterDropColor: ColorName.primaryColor,
        idleIcon: SizedBox(),
      ),
      footer: ClassicFooter(
        height: 100,
        loadingText: '',
        canLoadingText: '',
        idleText: '',
        loadingIcon: loadingIcon ??
            const CircularProgressIndicator(color: ColorName.primaryColor),
        idleIcon: const SizedBox(),
      ),
      child: child,
    );
  }
}
