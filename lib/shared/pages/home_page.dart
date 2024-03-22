import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat_page.dart';
import 'package:leaf_lore_flutter/features/home/dashboard_page.dart';
import 'package:leaf_lore_flutter/features/plants/plants_page.dart';
import 'package:leaf_lore_flutter/features/profile/profile_page.dart';
import 'package:leaf_lore_flutter/shared/theme/bottom_navigation_bar_widget.dart';
import 'package:leaf_lore_flutter/shared/theme/main_app_bar_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String title = 'Leaf Lore';
  final List<Widget> _pages = [
    const DashboardPage(),
    ChatNavigationWrapper(),
    PlantsPage(),
    ProfilePage()
  ]; // Add your pages here

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: MainAppBar(title: title),
        body: Container(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:
                    Alignment(-0.1, -1.0),
                end: Alignment(0.1, 2.5),
                colors: [
                  Colors.white,
                  Colors.lightGreen[300]!,
                  Colors.green,
                  Colors.green[900]!,
                  Colors.lightGreen[
                      300]!, 
                ],
                stops: [0.05, 0.25, 0.55, 0.75, 0.90],
              ),
            ),
            child: _pages.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBarWidget(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped));
  }
}
