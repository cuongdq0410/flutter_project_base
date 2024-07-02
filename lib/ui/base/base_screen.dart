import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
}

abstract class BaseState<S extends BaseScreen, B extends Bloc>
    extends State<S> {
  late B bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<B>();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      afterBuild();
    });
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  afterBuild();

  Widget buildContent(BuildContext context);

  hideKeyboard() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  ///***************************************************************************
  /// NAVIGATOR
  ///***************************************************************************

  Future<dynamic> pushScreen(String routeName, {dynamic arguments}) {
    debugPrint("pushScreen ===> $routeName");
    return context.pushNamed(routeName, extra: arguments ?? {});
  }

  void pushDialog(StatefulWidget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        fullscreenDialog: true,
        pageBuilder: (_, __, ___) => screen,
      ),
    );
  }

  void replaceScreen(String routeName, {Map<String, String>? arguments}) {
    Navigator.popUntil(context, (route) => route.isFirst);
    debugPrint("replaceScreen ===> $routeName");
    context.pushReplacementNamed(routeName, pathParameters: arguments ?? {});
  }

  void popScreen() {
    debugPrint("popScreen <=== ");
    context.pop();
  }

  void popMultiScreen(int pop) {
    for (int i = 0; i < pop; i++) {
      context.pop();
    }
  }

  void popUntilScreen(Type screen) {
    debugPrint("${screen.toString()} <=== popUntilScreen");
    Navigator.popUntil(
      context,
      (route) => route.isFirst || route.settings.name == screen.toString(),
    );
  }
}
