

import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/features/plants/plant_detail_page.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';

class PlantListWidget extends StatelessWidget {
  const PlantListWidget({
    super.key,
    required this.plants,
  });

  final List<PlantMeta> plants;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plants.length,
      itemBuilder: (context, index) {
        PlantMeta plant = plants[index];
        return Card(
          child: ListTile(
            title: Text(plant.name),
            // subtitle: Text('Age: ${plant.age}'),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlantDetailPage(plantMeta: plant)),
                );
              },
              child: Text(context.loc.plantList_viewDetails),
            ),
          ),
        );
      },
    );
  }
}