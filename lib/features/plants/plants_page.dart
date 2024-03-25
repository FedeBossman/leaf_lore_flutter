import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/plants/plant_detail_page.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';

class PlantsPage extends StatelessWidget {
  // list of plants
  final List<Plant> plants = [
    Plant(name: 'Aloe Vera', age: "2"),
    Plant(name: 'Basil', age: "1"),
    Plant(name: 'Mint', age: "3"),
    Plant(name: 'Rosemary', age: "4"),
  ];

  PlantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          Plant plant = plants[index];
          return Card(
            child: ListTile(
              title: Text(plant.name),
              subtitle: Text('Age: ${plant.age}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Navigate to the plant's detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlantDetailPage(plant: plant)),
                  );
                },
                child: Text('View Details'),
              ),
            ),
          );
        },
      );
  }
}
