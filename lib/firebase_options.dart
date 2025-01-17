// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBTN0st7w8WatxHs-hQnjVAIXCclAa6LE8',
    appId: '1:73666676585:web:12b11a0e9c1ad3081c5ff8',
    messagingSenderId: '73666676585',
    projectId: 'chat-app-70575',
    authDomain: 'chat-app-70575.firebaseapp.com',
    storageBucket: 'chat-app-70575.firebasestorage.app',
    measurementId: 'G-4GN7EZMZQR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOGj00RUsp-G90s3vOBcfEG5Ag1OB1G7k',
    appId: '1:73666676585:android:bd35193959c5c5ea1c5ff8',
    messagingSenderId: '73666676585',
    projectId: 'chat-app-70575',
    storageBucket: 'chat-app-70575.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA39CV2ycYnkwvDb4ocb1riOTF5vykif1k',
    appId: '1:73666676585:ios:f4d0602483e4ed4f1c5ff8',
    messagingSenderId: '73666676585',
    projectId: 'chat-app-70575',
    storageBucket: 'chat-app-70575.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA39CV2ycYnkwvDb4ocb1riOTF5vykif1k',
    appId: '1:73666676585:ios:f4d0602483e4ed4f1c5ff8',
    messagingSenderId: '73666676585',
    projectId: 'chat-app-70575',
    storageBucket: 'chat-app-70575.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBTN0st7w8WatxHs-hQnjVAIXCclAa6LE8',
    appId: '1:73666676585:web:3cc98f851721cd781c5ff8',
    messagingSenderId: '73666676585',
    projectId: 'chat-app-70575',
    authDomain: 'chat-app-70575.firebaseapp.com',
    storageBucket: 'chat-app-70575.firebasestorage.app',
    measurementId: 'G-8M3T61JGK1',
  );
}
