// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCj_-GapGd3L_2U0JeCSMrh-Vjd-lmq2rk',
    appId: '1:382888234390:web:51a3a5a9dd43468debe1b7',
    messagingSenderId: '382888234390',
    projectId: 'leaflore-a0c06',
    authDomain: 'leaflore-a0c06.firebaseapp.com',
    storageBucket: 'leaflore-a0c06.appspot.com',
    measurementId: 'G-H48ERPCN42',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCh_6gjw9ONyrZXFhH5NcbsrfYrb9ABOjM',
    appId: '1:382888234390:android:6da8a4707047cc0bebe1b7',
    messagingSenderId: '382888234390',
    projectId: 'leaflore-a0c06',
    storageBucket: 'leaflore-a0c06.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYA1zzbDEZ23ue9DsSV7-qQtngU7RcCxU',
    appId: '1:382888234390:ios:e2a0740646d789aaebe1b7',
    messagingSenderId: '382888234390',
    projectId: 'leaflore-a0c06',
    storageBucket: 'leaflore-a0c06.appspot.com',
    iosClientId: '382888234390-2c60mc8bh0ugr9a6otatflq4r0b4r0fd.apps.googleusercontent.com',
    iosBundleId: 'com.example.leafLoreFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYA1zzbDEZ23ue9DsSV7-qQtngU7RcCxU',
    appId: '1:382888234390:ios:e2a0740646d789aaebe1b7',
    messagingSenderId: '382888234390',
    projectId: 'leaflore-a0c06',
    storageBucket: 'leaflore-a0c06.appspot.com',
    iosClientId: '382888234390-2c60mc8bh0ugr9a6otatflq4r0b4r0fd.apps.googleusercontent.com',
    iosBundleId: 'com.example.leafLoreFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCj_-GapGd3L_2U0JeCSMrh-Vjd-lmq2rk',
    appId: '1:382888234390:web:08f24ac3d50c99a9ebe1b7',
    messagingSenderId: '382888234390',
    projectId: 'leaflore-a0c06',
    authDomain: 'leaflore-a0c06.firebaseapp.com',
    storageBucket: 'leaflore-a0c06.appspot.com',
    measurementId: 'G-GS101PTGSB',
  );

}