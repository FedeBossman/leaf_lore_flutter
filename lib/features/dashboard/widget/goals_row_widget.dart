import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/text_extension.dart';

class GoalsRow extends StatelessWidget {
  final List<String> goals;

  const GoalsRow({super.key, required this.goals});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.flag, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Column(
          children: goals.map((goal) =>  Text(goal.toFirstUpperCase(), style: const TextStyle(fontSize: 16))).toList(),
        )
      ],
    );
  }
}
