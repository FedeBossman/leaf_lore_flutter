import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/firebase/tips_service.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class DailyTipWidget extends StatefulWidget {
  const DailyTipWidget({super.key});

  @override
  DailyTipWidgetState createState() => DailyTipWidgetState();
}

class DailyTipWidgetState extends State<DailyTipWidget> {
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
        gradient: LeafLoreColors.tiffanyBlueGradient,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.loc.dailyTip_title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: LeafLoreColors.spaceCadet),
          ),
          const SizedBox(height: 8),
          dailyTip == null
              ? const Center(child: CircularProgressIndicator())
              : Text(dailyTip!, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
