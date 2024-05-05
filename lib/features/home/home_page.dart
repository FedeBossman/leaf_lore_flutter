import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaf_lore_flutter/core/widget/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/chat/chat.model.dart';
import 'package:leaf_lore_flutter/features/chat/chat_detail_page.dart';
import 'package:leaf_lore_flutter/features/chat/chat_page.dart';
import 'package:leaf_lore_flutter/features/chat/chat_stream.dart';
import 'package:leaf_lore_flutter/features/home/dashboard_page.dart';
import 'package:leaf_lore_flutter/features/plants/plants_page.dart';
import 'package:leaf_lore_flutter/features/profile/profile_page.dart';
import 'package:leaf_lore_flutter/shared/theme/bottom_navigation_bar_widget.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  bool _isChatPage() {
    return _currentPage == ChatNavigationWrapper.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (_navigatorKeys[_currentPage]!.currentState!.canPop()) {
          return;
        } else if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else if (_selectedIndex != 0) {
          _onItemTapped(DashboardPage.tabIndex, 0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LeafLoreColors.lightGradient,
        ),
        child: Scaffold(
            extendBody: false,
            body: SafeArea(
              child: Stack(children: <Widget>[
                _buildOffstageNavigator(DashboardPage.tabIndex),
                _buildOffstageNavigator(ChatNavigationWrapper.tabIndex),
                _buildOffstageNavigator(PlantNavigationWrapper.tabIndex),
                _buildOffstageNavigator(ProfilePage.tabIndex),
              ]),
            ),
            floatingActionButton: StreamHandler<ChatMeta>(
              stream: getDefaultChatMetaStream(),
              builder: (context, snapshot) {
                final chatMeta = snapshot.data!;
                return Visibility(
                  visible: chatMeta != null && !_isChatPage(),
                  child: FloatingActionButton(
                    heroTag: 'assistantFab',
                    onPressed: () {
                      setState(() {
                        _onItemTapped(ChatNavigationWrapper.tabIndex, 1);
                        var chatContext =
                            _navigatorKeys[ChatNavigationWrapper.tabIndex]!
                                .currentContext;

                        Navigator.push(
                            chatContext!,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChatDetailPage(
                                        chatId: chatMeta.id,
                                        chatName: chatMeta.name)));
                      });
                    },
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(
                            color: LeafLoreColors.tiffanyBlue, width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                    foregroundColor: LeafLoreColors.tiffanyBlue,
                    backgroundColor: LeafLoreColors.leafWhite,
                    tooltip: 'Assistant',
                    child: const Icon(Icons.assistant), // Tooltip text
                  ),
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: BottomNavigationBarWidget(
                pageKeys: pageKeys,
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped)),
      ),
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
      child = const ProfilePage();
    } else {
      child = const DashboardPage();
    }

    return NavigatorPopHandler(
      onPop: () {
        navigatorKey.currentState?.maybePop();
      },
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) => child);
        },
      ),
    );
  }
}
