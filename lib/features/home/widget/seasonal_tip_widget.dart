import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/firebase/tips_service.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class SeasonalTipWidget extends StatefulWidget {
  const SeasonalTipWidget({super.key});

  @override
  SeasonalTipWidgetState createState() => SeasonalTipWidgetState();
}

class SeasonalTipWidgetState extends State<SeasonalTipWidget> {
  String? seasonalTip;

  @override
  void initState() {
    super.initState();
    fetchSeasonalTip();
  }

  Future<void> fetchSeasonalTip() async {
    final result = await getSeasonalTip();
    setState(() {
      seasonalTip = result.data['tip'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LeafLoreColors.skyBlueGradient,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.loc.seasonalTip_title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: LeafLoreColors.spaceCadet),
          ),
          const SizedBox(height: 8),
          seasonalTip == null
              ? const Center(child: CircularProgressIndicator())
              : Text(seasonalTip!, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
