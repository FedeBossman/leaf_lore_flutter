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

        return Container(
          padding: const EdgeInsets.all(8), 
          child: ListTile(
              leading: CircleAvatar(
                minRadius: 20,
                maxRadius: 30,
                child: Text(plant.name[0]),
              ),
              title: Text(plant.name),
              subtitle: Text(
                plant.nickname,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PlantDetailPage(plantMeta: plant)),
                  );
                },
                child: Text(context.loc.plantList_viewDetails),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlantDetailPage(plantMeta: plant)),
                );
              }),
        );
      },
    );
  }
}
