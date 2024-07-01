import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
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
        showErrorMessage(context.loc.registerPage_passwordsDoNotMatch);
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
        showSuccessMessage(context.loc.registerPage_userCreatedSuccessfully);
        Navigator.of(context).popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        showFirebaseErrorMessage(e);
      } catch (e) {
        setState(() => _isLoading = false);
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
        appBar: MainAppBar(
            title: context.loc.registerPage_title, showBackButton: true),
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
                          decoration: InputDecoration(
                              labelText: context.loc.registerPage_nameLabel),
                          validator: (value) => value!.isEmpty
                              ? context.loc.registerPage_nameValidationMessage
                              : null,
                          onChanged: (value) => _name = value,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: context.loc.registerPage_emailLabel),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context
                                  .loc.registerPage_emailEmptyValidationMessage;
                            } else if (!RegExp(
                                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                                .hasMatch(value)) {
                              return context
                                  .loc.registerPage_emailValidationMessage;
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
                          decoration: InputDecoration(
                              labelText:
                                  context.loc.registerPage_passwordLabel),
                          obscureText: true,
                          validator: (value) => value!.length < 6
                              ? context
                                  .loc.registerPage_passwordValidationMessage
                              : null,
                          onChanged: (value) => _password = value,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: context
                                  .loc.registerPage_confirmPasswordLabel),
                          obscureText: true,
                          validator: (value) => value!.length < 6
                              ? context
                                  .loc.registerPage_passwordValidationMessage
                              : null,
                          onChanged: (value) => _confirmPassword = value,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: MainButton(
                          onPressed: _register,
                          text: context.loc.registerPage_registerButtonLabel,
                          isLoading: _isLoading,
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

  void showFirebaseErrorMessage(FirebaseAuthException firebaseException) {
    debugPrint('Firebase error: ${firebaseException.message}');
    if (firebaseException.code == 'weak-password') {
      showErrorMessage(context.loc.registerPage_passwordIsTooWeak);
    } else if (firebaseException.code == 'email-already-in-use') {
      showErrorMessage(context.loc.registerPage_accountAlreadyExists);
    } else if (firebaseException.code == 'network-request-failed') {
      showErrorMessage(context.loc.registerPage_networkErrorMessage);
    } else {
      showErrorMessage(context.loc.registerPage_unknownErrorMessage);
    }
  }
}
