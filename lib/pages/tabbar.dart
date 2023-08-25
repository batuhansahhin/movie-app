import 'package:bte_project/pages/login_page.dart';
import 'package:bte_project/pages/singin_page.dart';
import 'package:flutter/material.dart';

class MyTabbar extends StatefulWidget {
  const MyTabbar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyTabbarState createState() => _MyTabbarState();
}

class _MyTabbarState extends State<MyTabbar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final double _notchedValue = 10;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _MyTabViews.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _MyTabViews.values.length,
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _tabController.animateTo(_MyTabViews.signIn.index);
          },
          child: const Icon(Icons.movie),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: _notchedValue,
          child: _buildTabBar(),
        ),
        body: _buildTabBarView(),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: _MyTabViews.values.map((e) => Tab(text: e.name)).toList(),
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: const [
        LoginPage(),
        SingInPage(),
      ],
    );
  }
}

enum _MyTabViews {
  login,
  signIn,
}

extension _MyTabViewExtension on _MyTabViews {
  String get name {
    switch (this) {
      case _MyTabViews.login:
        return 'Login';
      case _MyTabViews.signIn:
        return 'Sign In';
      default:
        return '';
    }
  }
}
