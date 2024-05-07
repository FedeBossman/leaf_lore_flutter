import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/shared/presentation/leaf_card.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class EmptyDataPlaceholder extends StatelessWidget {
  final String text;
  final String subText;

  const EmptyDataPlaceholder(
      {super.key, required this.text, required this.subText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LeafCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18.0, color: LeafLoreColors.spaceCadet),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14.0, color: LeafLoreColors.leafGray),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between text and icon
            const Icon(
              Icons.arrow_downward_rounded,
              size: 84.0,
              color: LeafLoreColors.tiffanyBlue, // Custom color for the icon
            ),
          ],
        ),
      ),
    );
  }
}
