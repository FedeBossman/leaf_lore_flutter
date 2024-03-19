import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:leaf_lore_flutter/core/firebase/tips_service.dart';

class DailyTipWidget extends StatefulWidget {
  @override
  _DailyTipWidgetState createState() => _DailyTipWidgetState();
}

class _DailyTipWidgetState extends State<DailyTipWidget> {
  String? dailyTip;

  @override
  void initState() {
    super.initState();
    fetchDailyTip();
  }

  Future<void> fetchDailyTip() async {
    final result = await getDailyTip();
    setState(() {
      dailyTip = result.data['tip'];
    });
  }

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
          const Text(
            'Daily Tip:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 8),
          dailyTip == null
              ? const CircularProgressIndicator()  // Show loading indicator while the tip is null
              : Text(dailyTip!, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
