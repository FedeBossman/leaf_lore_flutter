import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_lore_flutter/features/home/home_page.dart';
import 'package:leaf_lore_flutter/shared/presentation/main_button.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';
import 'package:leaf_lore_flutter/shared/theme/main_app_bar_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _confirmPassword = '', _name = '';
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_password != _confirmPassword) {
        showErrorMessage('Passwords do not match.');
        return;
      }
      try {
        setState(() => _isLoading = true);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        User? user = userCredential.user;
        await user!.updateDisplayName(_name);
        // await FirebaseAuth.instance.currentUser?.sendEmailVerification();
        showSuccessMessage('User created successfully');
        Navigator.of(context).popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        debugPrint('Firebase error: ${e.message}');
        if (e.code == 'weak-password') {
          showErrorMessage(
              'The password provided is too weak, please try another password.');
        } else if (e.code == 'email-already-in-use') {
          showErrorMessage('An account already exists for that email.');
        } else if (e.code == 'network-request-failed') {
          showErrorMessage('Network request failed. Please try again later.');
        } else {
          showErrorMessage('An unknown error ocurred.');
        }
      } catch (e) {
        setState(() => _isLoading = false);
        print(e);
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: const MainAppBar(title: 'Register', showBackButton: true),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LeafLoreColors.pinkGradient,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                    tag: 'logo',
                    child: Image.asset("assets/images/logo.png",
                        width: 150, height: 150)),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your name' : null,
                          onChanged: (value) => _name = value,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            } else if (!RegExp(
                                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onChanged: (value) => _email = value,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) => value!.length < 6
                              ? 'Password must be at least 6 characters'
                              : null,
                          onChanged: (value) => _password = value,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value) => value!.length < 6
                              ? 'Password must be at least 6 characters'
                              : null,
                          onChanged: (value) => _confirmPassword = value,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: MainButton(
                          onPressed: _register,
                          text: 'Register',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSuccessMessage(String successMessage) {
    debugPrint(successMessage);
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
          content: Text(successMessage),
          backgroundColor: Theme.of(context).primaryColor),
    );
  }

  void showErrorMessage(String errorMessage) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
    );
  }
}
