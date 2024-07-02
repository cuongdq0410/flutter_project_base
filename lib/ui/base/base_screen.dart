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

  Future<dynamic> pushNameScreen(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    debugPrint("pushScreen ===> $routeName");
    return context.pushNamed(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void pushReplacementNamed(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    debugPrint("pushReplacementNamed ===> $routeName");
    context.pushReplacementNamed(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void pushNameAndRemoveUtil(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    debugPrint("pushNameAndRemoveUtil ===> $routeName");
    context.goNamed(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void pop() {
    debugPrint("pop <=== ");
    context.pop();
  }
}
