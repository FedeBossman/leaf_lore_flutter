
import 'package:flutter/material.dart';

class LlAccentButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;

  LlAccentButton({
    required this.onPressed,
    this.child,
    this.text,
    this.color,
    this.padding,
    this.shape,
  })  : assert(child != null || text != null,
            'One of "child" or "text" needs to be set'),
        assert(child == null || text == null,
            'Only one of "child" or "text" can be set');

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).buttonTheme;
    return ElevatedButton(
      // Required
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(padding ?? EdgeInsets.fromLTRB(4, 12, 4, 12)),
        // shape: MaterialStateProperty.all(shape ?? buttonTheme.shape),
        elevation: MaterialStateProperty.all(0),
      ),
      // Override
      child: child ??
          Text(text!.toUpperCase()),
    );
  }
}
