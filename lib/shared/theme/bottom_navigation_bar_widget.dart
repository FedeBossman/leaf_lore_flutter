import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

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
          BoxShadow(color: LeafLoreColors.tiffanyBlue, spreadRadius: 2.5, blurRadius: 0.0),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: context.loc.bottomNavigationBar_home),
            BottomNavigationBarItem(
                icon: const Icon(Icons.chat),
                label: context.loc.bottomNavigationBar_chat),
            BottomNavigationBarItem(
                icon: const Icon(Icons.local_florist),
                label:
                    context.loc.bottomNavigationBar_plants),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label:
                    context.loc.bottomNavigationBar_profile),
          ],
          currentIndex: selectedIndex,
          onTap: (int index) {
            onItemTapped(pageKeys[index], index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: LeafLoreColors.leafWhite,
          // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
      ),
    );
  }
}
