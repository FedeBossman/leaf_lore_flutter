import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/shared/presentation/unicorn_outline_button.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const MainButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});

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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: isLoading ? 0.0 : 1.0,
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          Opacity(
            opacity: isLoading ? 1.0 : 0.0,
            child: const SizedBox(
              height: 20, // Make sure this matches the text size
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
