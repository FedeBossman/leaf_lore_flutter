import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:leaf_lore_flutter/features/home/home_page.dart';
import 'package:leaf_lore_flutter/features/login/login_page.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';
import 'package:leaf_lore_flutter/shared/theme/debug.dart';
import 'package:leaf_lore_flutter/shared/theme/theme.dart';
import 'core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  FlutterError.onError = (FlutterErrorDetails details) { 
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (debugMode) {
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
  final List<Locale> systemLocales =
      WidgetsBinding.instance.platformDispatcher.locales;


  runApp(MyApp(defaultSystemLocale, systemLocales));
}

class MyApp extends StatefulWidget {
  final String initialDefaultSystemLocale;
  final List<Locale> initialSystemLocales;

  const MyApp(this.initialDefaultSystemLocale, this.initialSystemLocales,
      {super.key});

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: LeafLoreColors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: LeafLoreColors.leafWhite,
        systemNavigationBarColor: LeafLoreColors.leafWhite));

    return MaterialApp(
      title: 'LeafLore',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      theme: appTheme(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              //} || !user.emailVerified) {
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
