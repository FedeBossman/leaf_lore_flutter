import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_lore_flutter/shared/presentation/main_button.dart';
import 'package:leaf_lore_flutter/shared/theme/debug.dart';

class ProfilePage extends StatefulWidget {
  static const String tabIndex = 'ProfilePage';

  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final String name = user?.displayName ?? 'No Name Available';
    final String email = user?.email ?? 'No Email Available';
    final String uid = user?.uid ?? 'No Email Available';
    final Color color = Theme.of(context).primaryColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 80,
                  child: Image.asset("assets/images/logo.png",
                      width: 120, height: 120)
                  //   Text(
                  //   name[0],
                  //   style: const TextStyle(fontSize: 40, color: Colors.white),
                  // ),
                  ),
              const SizedBox(height: 20),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              MinWidthDivider(
                  child: Text(
                email,
                style: TextStyle(color: Colors.grey[600], fontSize: 18),
              )),
              Visibility(
                visible: debugMode,
                child: MinWidthDivider(
                    child: Text(
                  uid,
                  style: TextStyle(color: Colors.grey[600], fontSize: 18),
                )),
              ),
              const SizedBox(height: 40),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: MainButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await _auth.signOut();
                      setState(() {
                        _isLoading = true;
                      });
                    },
                    text: 'Sign Out',
                    isLoading: _isLoading),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class MinWidthDivider extends StatelessWidget {
  const MinWidthDivider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Divider(),
              child,
            ],
          ),
        ),
      ],
    );
  }
}
