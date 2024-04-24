import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_lore_flutter/shared/pages/home_page.dart';
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
        showSuccessMessage('User created successfully');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      } on FirebaseAuthException catch (e) {
        setState(() => _isLoading = false);
        if (e.code == 'weak-password') {
          const String errorMessage =
              'The password provided is too weak, please try another password.';
          showErrorMessage(errorMessage);
        } else if (e.code == 'email-already-in-use') {
          const String errorMessage =
              'An account already exists for that email.';
          showErrorMessage('An account already exists for that email.');
        }
      } catch (e) {
        setState(() => _isLoading = false);
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: const MainAppBar(title: 'Register', showBackButton: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your email' : null,
                        onChanged: (value) => _email = value,
                      ),
                    ),
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
                    if (_isLoading) const CircularProgressIndicator(),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessMessage(String successMessage) {
    print(successMessage);
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(successMessage), backgroundColor: Colors.green),
    );
  }

  void showErrorMessage(String errorMessage) {
    print(errorMessage);
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
    );
  }
}