import 'package:flutter/material.dart';

class LeafCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double? borderRadius;
  final double? elevation;

  const LeafCard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(32.0), this.borderRadius, this.elevation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: child,
      ),
    );
  }
}
