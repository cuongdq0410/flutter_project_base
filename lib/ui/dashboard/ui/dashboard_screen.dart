import 'package:flutter/material.dart';
import 'package:flutter_bloc_base/ui/widget/route_define.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/l10n.dart';

class DashboardScreen extends StatelessWidget {
  final List<Widget> children;
  final StatefulNavigationShell navigationShell;

  const DashboardScreen(
      {super.key, required this.children, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: children,
        index: navigationShell.currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: S.of(context).chat,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: S.of(context).profile,
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/${RouteDefine.homeScreen.name}')) {
      return 0;
    }
    if (location.startsWith('/${RouteDefine.conversationScreen.name}')) {
      return 1;
    }
    if (location.startsWith('/${RouteDefine.profileScreen.name}')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(index);
  }
}
