import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/pages/home_page.dart';
import 'package:leaf_lore_flutter/widgets/social_sign_in_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  bool _isLoading = false;

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyHomePage()));
    } on FirebaseAuthException catch (e) {
      final String errorMessage = e.message ?? 'An unknown error occurred';
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    _emailController;
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const FlutterLogo(size: 100), // Your logo here (replace `FlutterLogo`)
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _signInWithEmailAndPassword,
                    child: const Text('Sign In'),
                  ),
                const SizedBox(height: 12),
                const SocialSignInWidget(),
                TextButton(
                  onPressed: () {
                    // Navigate to forgot password page or functionality
                  },
                  child: const Text('Forgot password'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to registration page or functionality
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
