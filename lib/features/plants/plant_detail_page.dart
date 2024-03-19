import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  PlantDetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${plant.name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Age: ${plant.age}', style: TextStyle(fontSize: 16)),
            // Add more plant details here
          ],
        ),
      ),
    );
  }
}
