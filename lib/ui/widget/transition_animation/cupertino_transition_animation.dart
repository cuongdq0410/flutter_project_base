import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class CupertinoTransitionPage<T> extends CustomTransitionPage<T> {
  CupertinoTransitionPage({required Widget child})
      : super(
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: true,
            child: child,
          ),
        );
}
