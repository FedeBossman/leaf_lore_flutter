import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/chat/chat_page.dart';
import 'package:leaf_lore_flutter/features/home/dashboard_page.dart';
import 'package:leaf_lore_flutter/features/plants/plants_page.dart';
import 'package:leaf_lore_flutter/features/profile/profile_page.dart';
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
      appBar: MainAppBar(title: title),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_florist), label: 'Plants'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.green, 
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
