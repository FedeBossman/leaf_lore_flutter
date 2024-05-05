import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class LeafChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final BorderSide side;

  const LeafChip({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor = Colors.white,
    this.side = const BorderSide(color: Colors.black, width: 1),
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = LeafLoreColors.tiffanyBlue;

    return Chip(
      label: icon != null
          ? Wrap(
              children: [
                Icon(
                  icon,
                  color: LeafLoreColors.tiffanyBlue,
                ),
                const SizedBox(width: 12),
                Text(label)
              ],
            )
          : Text(label),
      backgroundColor: Colors.white,
      side: const BorderSide(color: accentColor, width: 1),
    );
  }
}
