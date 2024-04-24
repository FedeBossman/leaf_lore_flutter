import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat_page.dart';
import 'package:leaf_lore_flutter/features/home/dashboard_page.dart';
import 'package:leaf_lore_flutter/features/plants/plants_page.dart';
import 'package:leaf_lore_flutter/features/profile/profile_page.dart';
import 'package:leaf_lore_flutter/shared/theme/bottom_navigation_bar_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'Leaf Lore';

  String _currentPage = DashboardPage.tabIndex;
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    DashboardPage.tabIndex: GlobalKey<NavigatorState>(),
    ChatNavigationWrapper.tabIndex: GlobalKey<NavigatorState>(),
    PlantNavigationWrapper.tabIndex: GlobalKey<NavigatorState>(),
    ProfilePage.tabIndex: GlobalKey<NavigatorState>(),
  };

  late List<String> pageKeys;

  int _selectedIndex = 0;

  _MyHomePageState() {
    pageKeys = _navigatorKeys.keys.toList();
  }

  void _onItemTapped(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          extendBody: true,
          // appBar: MainAppBar(title: title),
          body: Container(
              padding:
                  const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     begin:
              //         Alignment(-0.1, -1.0),
              //     end: Alignment(0.1, 2.5),
              //     colors: [
              //       Colors.white,
              //       Colors.lightGreen[300]!,
              //       Colors.green,
              //       Colors.green[900]!,
              //       Colors.lightGreen[
              //           300]!,
              //     ],
              //     stops: [0.05, 0.25, 0.55, 0.75, 0.90],
              //   ),
              // ),
              child: Stack(children: <Widget>[
                _buildOffstageNavigator(DashboardPage.tabIndex),
                _buildOffstageNavigator(ChatNavigationWrapper.tabIndex),
                _buildOffstageNavigator(PlantNavigationWrapper.tabIndex),
                _buildOffstageNavigator(ProfilePage.tabIndex),
              ])),
          bottomNavigationBar: BottomNavigationBarWidget(
              pageKeys: pageKeys,
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped)),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == DashboardPage.tabIndex) {
      child = const DashboardPage();
    } else if (tabItem == ChatNavigationWrapper.tabIndex) {
      child = const ChatNavigationWrapper();
    } else if (tabItem == PlantNavigationWrapper.tabIndex) {
      child = const PlantNavigationWrapper();
    } else if (tabItem == ProfilePage.tabIndex) {
      child = ProfilePage();
    } else {
      child = const DashboardPage();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
