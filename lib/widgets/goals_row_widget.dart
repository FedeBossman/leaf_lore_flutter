import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/extensions/text_extension.dart';

class GoalsRow extends StatelessWidget {
  final List<String> goals;

  GoalsRow({Key? key, required this.goals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.flag, color: Colors.green),
        const SizedBox(width: 8),
        Column(
          children: goals.map((goal) =>  Text(goal.toFirstUpperCase(), style: const TextStyle(fontSize: 16))).toList(),
        )
      ],
    );
  }
}
