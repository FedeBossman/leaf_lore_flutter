import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/widget/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/plants/widget/plant_detail_widget.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';
import 'package:leaf_lore_flutter/features/plants/plant_stream.dart';
import 'package:leaf_lore_flutter/shared/theme/main_app_bar_widget.dart';

class PlantDetailPage extends StatelessWidget {
  final PlantMeta plantMeta;

  const PlantDetailPage({super.key, required this.plantMeta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: plantMeta.name, showBackButton: true),
      body: StreamHandler<Plant>(
          stream: getPlantDetailStream(plantMeta.id),
          builder: (context, snapshot) {
            var plant = snapshot.data!;
            return PlantDetailWidget(plant: plant);
          }),
    );
  }
}
