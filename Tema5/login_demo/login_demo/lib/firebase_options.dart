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
    apiKey: 'AIzaSyDyobcfFFJIJoRA9B715uw3-vYG4QfyzEM',
    appId: '1:649494341827:web:620f2f7f9d53f8078dda76',
    messagingSenderId: '649494341827',
    projectId: 'provant-dda36',
    authDomain: 'provant-dda36.firebaseapp.com',
    databaseURL: 'https://provant-dda36-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'provant-dda36.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB51YwefqGW6rf3v0BZ2i-OmkBE3KGQq0g',
    appId: '1:649494341827:android:309c6747f4556bab8dda76',
    messagingSenderId: '649494341827',
    projectId: 'provant-dda36',
    databaseURL: 'https://provant-dda36-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'provant-dda36.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_NGXq5PMYOtZi17jcNHzHfK3JRLJL16Y',
    appId: '1:649494341827:ios:38c71743288bf86b8dda76',
    messagingSenderId: '649494341827',
    projectId: 'provant-dda36',
    databaseURL: 'https://provant-dda36-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'provant-dda36.firebasestorage.app',
    iosBundleId: 'com.example.loginDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_NGXq5PMYOtZi17jcNHzHfK3JRLJL16Y',
    appId: '1:649494341827:ios:38c71743288bf86b8dda76',
    messagingSenderId: '649494341827',
    projectId: 'provant-dda36',
    databaseURL: 'https://provant-dda36-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'provant-dda36.firebasestorage.app',
    iosBundleId: 'com.example.loginDemo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDyobcfFFJIJoRA9B715uw3-vYG4QfyzEM',
    appId: '1:649494341827:web:9860a7762a71329d8dda76',
    messagingSenderId: '649494341827',
    projectId: 'provant-dda36',
    authDomain: 'provant-dda36.firebaseapp.com',
    databaseURL: 'https://provant-dda36-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'provant-dda36.firebasestorage.app',
  );

}