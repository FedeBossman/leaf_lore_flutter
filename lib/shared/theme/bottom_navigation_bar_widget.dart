import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final List<String> pageKeys;
  final int selectedIndex;
  final void Function(String, int) onItemTapped;

  const BottomNavigationBarWidget({
    super.key,
    required this.pageKeys,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_florist), label: 'Plants'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: selectedIndex,
          onTap: (int index) { onItemTapped(pageKeys[index], index); },
          backgroundColor: Colors.black12,
          elevation: 0,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
