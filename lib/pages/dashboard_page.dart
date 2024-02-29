import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
Widget build(BuildContext context) {
    // Placeholder data
    String userLocation = "Gotham City";
    String weather = "24°C";
    int plantCount = 4;
    String userRank = "Budding Botanist";
    String dailyTip = "Rotate your indoor plants slightly each week for even light exposure.";

    return SingleChildScrollView( // Ensures the page is scrollable if content doesn't fit
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Location and Weather
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 8),
                Text(userLocation, style: TextStyle(fontSize: 18)),
                Spacer(), // Use Spacer to push the next items to the end of the row
                Icon(Icons.wb_sunny, color: Colors.yellow),
                SizedBox(width: 8),
                Text(weather, style: TextStyle(fontSize: 18)),
              ],
            ),
            Divider(height: 30, thickness: 2),
            // Number of Plants and Rank
            Row(
              children: [
                Icon(Icons.local_florist, color: Colors.green),
                SizedBox(width: 8),
                Text('$plantCount Plants', style: TextStyle(fontSize: 18)),
                Spacer(),
                Text(userRank, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            SizedBox(height: 20),
            // Daily Tip Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade100, // Light green background for the tip section
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Daily Tip:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                  SizedBox(height: 8),
                  Text(dailyTip, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
