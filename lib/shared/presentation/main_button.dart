import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/shared/presentation/unicorn_outline_button.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  MainButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return UnicornOutlineButton(
      onPressed: onPressed,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 126, 223, 207),
          LeafLoreColors.tiffanyBlue,
          Color.fromARGB(255, 111, 200, 142),
        ],
        stops: [0.05, 0.25, 0.85],
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
