import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:leaf_lore_flutter/features/home/home_page.dart';
import 'package:leaf_lore_flutter/features/login/login_page.dart';
import 'core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    bool isAndroidDevice = false;
    String host = isAndroidDevice ? '192.168.1.186' : 'localhost';
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
    );
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    FirebaseFirestore.setLoggingEnabled(true);
  }

  final String defaultSystemLocale = Platform.localeName;
  final List<Locale> systemLocales = WidgetsBinding.instance.platformDispatcher.locales;

  runApp(MyApp(defaultSystemLocale, systemLocales));
}

class MyApp extends StatefulWidget {
  final String initialDefaultSystemLocale;
  final List<Locale> initialSystemLocales;

  const MyApp(this.initialDefaultSystemLocale, this.initialSystemLocales, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late String currentDefaultSystemLocale;
  late List<Locale> currentSystemLocales;

  void setCurrentValues() {
    currentSystemLocales = WidgetsBinding.instance.platformDispatcher.locales;
    currentDefaultSystemLocale = Platform.localeName;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); 
    super.initState();
  }

  @override
  void didChangeLocales(List<Locale>? locale) {
    super.didChangeLocales(locale);
    setState(() {
      setCurrentValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeafLore',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), 
        Locale('es'),
      ],
      theme: ThemeData(
        fontFamily: 'Nunito',
        // Define the default TextTheme to specify font weight
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontWeight: FontWeight.w300), // Light
          bodySmall: TextStyle(fontWeight: FontWeight.w300), // Light
          // Specify other text styles if necessary
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightGreen, background: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 4.0,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
        ),
        cardTheme: CardTheme(
          elevation: 0.0,
          shadowColor: Colors.black,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.lerp(
                BorderRadius.circular(100), BorderRadius.circular(150), 0.5)!,
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.elliptical(40, 90),
            //     topRight: Radius.elliptical(60, 100),
            //     bottomLeft: Radius.elliptical(40, 120),
            //     bottomRight: Radius.elliptical(60, 80)),
            // side: BorderSide(
            //   color: Colors.white,
            //   strokeAlign: BorderSide.strokeAlignCenter,
            //   width: 2.0,
            // ),
          ),
        ),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const LoginPage();
            } else {
              return const MyHomePage();
            }
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
