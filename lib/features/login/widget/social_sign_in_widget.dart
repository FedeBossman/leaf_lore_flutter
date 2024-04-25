import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/firebase/auth.dart';

class SocialSignInWidget extends StatefulWidget {
  const SocialSignInWidget({super.key});

  @override
  SocialSignInWidgetState createState() => SocialSignInWidgetState();
}

class SocialSignInWidgetState extends State<SocialSignInWidget> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isSigningIn
          ? const CircularProgressIndicator()
          : ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: Text(context.loc.socialSignIn_signInWithGoogle),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                final userCredential = await signInWithGoogle();
                if (userCredential.user != null) {
                  debugPrint("Signed in successfully: ${userCredential.user?.displayName}");
                  // TO DO: Navigate to another screen or perform other actions
                } else {
                  // Handle sign-in failure (e.g., show an error message)
                  // TO DO: Show error message
                  debugPrint("Failed to sign in with Google.");
                }
                setState(() {
                  _isSigningIn = false;
                });
              },
            ),
    );
  }
}
