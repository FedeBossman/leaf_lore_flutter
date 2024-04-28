import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/features/register/register_page.dart';
import 'package:leaf_lore_flutter/features/home/home_page.dart';
import 'package:leaf_lore_flutter/shared/presentation/main_button.dart';
import 'package:leaf_lore_flutter/shared/presentation/unicorn_outline_button.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyHomePage()));
    } on FirebaseAuthException catch (e) {
      // final String errorMessage = e.message ?? 'An unknown error occurred';
      final String errorMessage = context.loc.loginPage_unknownErrorMessage;
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
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
                Image.asset("assets/images/logo.png", width: 300, height: 300),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: context.loc.loginPage_emailLabel,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: context.loc.loginPage_passwordLabel,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: MainButton(
                    onPressed: _signInWithEmailAndPassword,
                    text: context.loc.loginPage_loginButtonLabel,
                  ),
                ),
                const SizedBox(height: 12),
                // const SocialSignInWidget(),
                // TextButton(
                //   onPressed: () {
                //     // Navigate to forgot password page or functionality
                //   },
                //   child: const Text('Forgot password'),
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RegisterPage()));
                  },
                  child: Text(context.loc.loginPage_registerButtonLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
