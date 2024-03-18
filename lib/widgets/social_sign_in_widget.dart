import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/firebase/auth.dart';

class SocialSignInWidget extends StatefulWidget {
  const SocialSignInWidget({super.key});

  @override
  _SocialSignInWidgetState createState() => _SocialSignInWidgetState();
}

class _SocialSignInWidgetState extends State<SocialSignInWidget> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isSigningIn
          ? const CircularProgressIndicator()
          : ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                final userCredential = await signInWithGoogle();
                if (userCredential.user != null) {
                  print("Signed in successfully: ${userCredential.user?.displayName}");
                  // Navigate to another screen or perform other actions
                } else {
                  // Handle sign-in failure (e.g., show an error message)
                  print("Failed to sign in with Google.");
                }
                setState(() {
                  _isSigningIn = false;
                });
              },
            ),
    );
  }
}
