import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/domain/usecases/usecases.dart';
import 'package:flutter_bloc_base/injection/injector.dart';
import 'package:flutter_bloc_base/ui/chat/ui/chat_screen.dart';
import 'package:flutter_bloc_base/ui/dashboard/profile/ui/profile_screen.dart';
import 'package:flutter_bloc_base/ui/dashboard/ui/dashboard_screen.dart';
import 'package:flutter_bloc_base/ui/login/ui/login_screen.dart';
import 'package:flutter_bloc_base/ui/splash/bloc/splash_bloc.dart';
import 'package:flutter_bloc_base/ui/splash/ui/splash_screen.dart';
import 'package:flutter_bloc_base/ui/widget/transition_animation/cupertino_transition_animation.dart';
import 'package:go_router/go_router.dart';

import '../../domain/usecases/user_usecase.dart';
import '../dashboard/conversation/ui/conversation_page.dart';
import '../dashboard/home/bloc/home_bloc.dart';
import '../dashboard/home/ui/home_screen.dart';
import '../login/bloc/login_bloc.dart';
import 'app_navigator.dart';

enum RouteDefine {
  splashScreen,
  loginScreen,
  forgotPasswordScreen,
  homeScreen,
  chatScreen,
  conversationScreen,
  profileScreen,
}

class GenerateRoute {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: AppNavigator.navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: RouteDefine.splashScreen.name,
        builder: (context, state) => widgetBuilder(
          const SplashScreen(),
          bloc: SplashBloc(
            injector.get<UserUseCase>(),
          ),
        ),
      ),
      GoRoute(
        name: RouteDefine.loginScreen.name,
        path: '/${RouteDefine.loginScreen.name}',
        builder: (context, state) => widgetBuilder(
          const LoginScreen(),
          bloc: LoginBloc(
            injector.get<AuthUseCase>(),
          ),
        ),
      ),
      StatefulShellRoute(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return navigationShell;
        },
        navigatorContainerBuilder: (BuildContext context,
            StatefulNavigationShell navigationShell, List<Widget> children) {
          return DashboardScreen(
            children: children,
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: RouteDefine.homeScreen.name,
                path: '/${RouteDefine.homeScreen.name}',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: widgetBuilder(
                      const HomeScreen(),
                      bloc: HomeBloc(),
                    ),
                  );
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: const Column(
                          children: [
                            Text('detail'),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: RouteDefine.conversationScreen.name,
                path: '/${RouteDefine.conversationScreen.name}',
                builder: (BuildContext context, GoRouterState state) {
                  return const ConversationPage();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) {
                      return const Scaffold();
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              StatefulShellRoute(
                builder: (BuildContext context, GoRouterState state,
                    StatefulNavigationShell navigationShell) {
                  return navigationShell;
                },
                navigatorContainerBuilder: (BuildContext context,
                    StatefulNavigationShell navigationShell,
                    List<Widget> children) {
                  return ProfileScreen(
                    navigationShell: navigationShell,
                    children: children,
                  );
                },
                branches: <StatefulShellBranch>[
                  StatefulShellBranch(
                    routes: <GoRoute>[
                      GoRoute(
                        path: '/${RouteDefine.profileScreen.name}1',
                        builder: (BuildContext context, GoRouterState state) {
                          return TabScreen(
                            label: 'Tab 1',
                            detailsPath:
                                '/${RouteDefine.profileScreen.name}1/details',
                          );
                        },
                        routes: <RouteBase>[
                          GoRoute(
                            path: 'details',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    const DetailsScreen(
                              label: 'Tab 1',
                              withScaffold: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: <GoRoute>[
                      GoRoute(
                        path: '/${RouteDefine.profileScreen.name}2',
                        builder: (BuildContext context, GoRouterState state) {
                          return TabScreen(
                            label: 'Tab 2',
                            detailsPath:
                                '/${RouteDefine.profileScreen.name}2/details',
                          );
                        },
                        routes: <RouteBase>[
                          GoRoute(
                            path: 'details',
                            builder:
                                (BuildContext context, GoRouterState state) {
                              print('=======DetailsScreen B2 Render');
                              return const DetailsScreen(
                                label: 'B2',
                                withScaffold: false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: RouteDefine.chatScreen.name,
        path: '/${RouteDefine.chatScreen.name}/:id/:chatName',
        pageBuilder: (context, state) {
          return CupertinoTransitionPage(
            child: ChatScreen(
              chatId: state.pathParameters['id'],
              chatName: state.pathParameters['chatName'],
              chatScreenArgs: state.extra as ChatScreenArgs?,
            ),
          );
        },
      ),
      GoRoute(
        path: '/parent-page',
        redirect: (_, __) => '/page1',
      ),
      GoRoute(
        path: '/child',
        redirect: (_, __) => '/page2',
      ),
      GoRoute(
        parentNavigatorKey: AppNavigator.navigatorKey,
        path: '/page1',
        builder: (BuildContext context, GoRouterState state) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
            body: Column(
              children: [
                const Text('Page 1'),
                TextButton(
                  onPressed: () {
                    context.push('/child');

                    /// Kết quả ưu tiên redirect route cha => chuyển về /page1
                  },
                  child: const Text('Push to child'),
                )
              ],
            ),
          );
        },
      ),
      GoRoute(
        path: '/page2',
        builder: (BuildContext context, GoRouterState state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Page 2'),
            ),
          );
        },
      ),
    ],
  );

  static Widget widgetBuilder<T extends Bloc, S extends Widget>(
    S screen, {
    T? bloc,
  }) {
    return bloc == null
        ? screen
        : BlocProvider<T>(
            create: (context) => bloc,
            child: screen,
          );
  }

  static Widget widgetBuilderBlocValue<T extends Bloc, S extends Widget>(
    S screen, {
    T? cubit,
  }) {
    return cubit == null
        ? screen
        : BlocProvider<T>.value(
            value: cubit,
            child: screen,
          );
  }
}
