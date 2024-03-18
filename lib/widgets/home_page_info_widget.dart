import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/extensions/text_extension.dart';
import 'package:leaf_lore_flutter/firebase/home_page_info_stream.dart';
import 'package:leaf_lore_flutter/model/home_page_info.model.dart';
import 'package:leaf_lore_flutter/extensions/list_extension.dart';
import 'package:leaf_lore_flutter/widgets/goals_row_widget.dart';

class HomePageInfoWidget extends StatelessWidget {
  const HomePageInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String weather = "24°C";
    int plantCount = 4;

    return StreamBuilder<DocumentSnapshot>(
      stream: getHomePageInfoStream(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (!snapshot.hasData) {
          return const Text("Chat with Sprout to get started!");
        }

        var homePageInfo = HomePageInfo.fromSnapshot(snapshot.data!);

        var location = [homePageInfo.location.city, homePageInfo.location.state].filterNotNull().join(", ");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Location and Weather
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green),
                const SizedBox(width: 8),
                Text(location, style: const TextStyle(fontSize: 18)),
                const Spacer(), 
                const Icon(Icons.wb_sunny, color: Colors.yellow),
                const SizedBox(width: 8),
                Text(weather, style: const TextStyle(fontSize: 18)),
              ],
            ),
            const Divider(height: 30, thickness: 2),
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: Colors.green),
                const SizedBox(width: 8),
                Text(homePageInfo.type, style: const TextStyle(fontSize: 18)),
                const Spacer(),
                Text(homePageInfo.experience.toFirstUpperCase(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const Divider(height: 30, thickness: 2),
            Row(
              children: [
                const Icon(Icons.local_florist, color: Colors.green),
                const SizedBox(width: 8),
                Text('$plantCount Plants', style: const TextStyle(fontSize: 18)),
                const Spacer(),
                Text(homePageInfo.nickname, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const Divider(height: 30, thickness: 2),
            GoalsRow(goals: homePageInfo.goals),

          ],
        );
      },
    );
  }
}
