import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {required this.navigationShell, required this.children, super.key});

  final StatefulNavigationShell navigationShell;

  final List<Widget> children;

  @override
  State<StatefulWidget> createState() => _ProfileScreenScreenState();
}

class _ProfileScreenScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
      length: widget.children.length,
      vsync: this,
      initialIndex: widget.navigationShell.currentIndex);

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _tabController.index = widget.navigationShell.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = widget.children
        .mapIndexed((int i, _) => Tab(text: 'Tab ${i + 1}'))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
          onTap: (int tappedIndex) => _onTabTap(context, tappedIndex),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.children,
      ),
    );
  }

  void _onTabTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(index);

    /// don't want to keep state
    /// use this
    // switch (index) {
    //   case 0:
    //     context.go('/${RouteDefine.profileScreen.name}1');
    //     break;
    //   case 1:
    //     context.go('/${RouteDefine.profileScreen.name}2');
    //     break;
    // }
  }
}

class TabScreen extends StatelessWidget {
  const TabScreen({required this.label, required this.detailsPath, super.key});

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Screen $label', style: Theme.of(context).textTheme.titleLarge),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              GoRouter.of(context).go(detailsPath);
            },
            child: const Text('View details'),
          ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    this.param,
    this.withScaffold = true,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  /// Optional param
  final String? param;

  /// Wrap in scaffold
  final bool withScaffold;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.withScaffold) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Details Screen - ${widget.label}'),
        ),
        body: _build(context),
      );
    } else {
      return ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: _build(context),
      );
    }
  }

  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Details for ${widget.label} - Counter: $_counter',
              style: Theme.of(context).textTheme.titleLarge),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Increment counter'),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.param != null)
            Text('Parameter: ${widget.param!}',
                style: Theme.of(context).textTheme.titleMedium),
          const Padding(padding: EdgeInsets.all(8)),
          if (!widget.withScaffold) ...<Widget>[
            const Padding(padding: EdgeInsets.all(16)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('< Back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ]
        ],
      ),
    );
  }
}
