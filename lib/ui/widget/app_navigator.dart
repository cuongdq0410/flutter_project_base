import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NavigatorStackAction {
  /// Keep all of stacks
  keep,

  /// Replace last stack
  replace,

  /// Remove all stacks
  removeAll,
}

class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  /// Get context.
  ///
  static BuildContext? get currentContext => navigatorKey.currentContext;
}
