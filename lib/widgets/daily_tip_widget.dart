
import 'package:flutter/material.dart';

class DailyTipWidget extends StatelessWidget {
  final String dailyTip = "Rotate your indoor plants slightly each week for even light exposure.";

  const DailyTipWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daily Tip:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
          const SizedBox(height: 8),
          Text(dailyTip, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
