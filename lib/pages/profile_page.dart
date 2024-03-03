import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final String name = user?.displayName ?? 'No Name Available';
    final String email = user?.email ?? 'No Email Available';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView(
            children: [
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.account_circle, size: 36, color: Colors.green),
                title: Text(name, style: TextStyle(fontSize: 18)),
                subtitle: Text('Name', style: TextStyle(color: Colors.black.withOpacity(0.6))),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.email, size: 36, color: Colors.green),
                title: Text(email, style: TextStyle(fontSize: 18)),
                subtitle: Text('Email', style: TextStyle(color: Colors.black.withOpacity(0.6))),
              ),
              Divider(),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text('Sign Out', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              // primary: Colors.red, // Button color
              // onPrimary: Colors.white, // Text color
              minimumSize: Size(double.infinity, 50), // Button size
            ),
          ),
        ),
      ],
    );
  }
}
