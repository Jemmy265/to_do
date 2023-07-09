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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBL1jdYcXcvmyjiKfb7nBXL3eB8PrT_7-A',
    appId: '1:865048516973:web:45e322e3f0a66644b46264',
    messagingSenderId: '865048516973',
    projectId: 'todo-app-af635',
    authDomain: 'todo-app-af635.firebaseapp.com',
    storageBucket: 'todo-app-af635.appspot.com',
    measurementId: 'G-079F2E9581',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMTV96LSJfHqSR-xtnWLJtO55NY5TBURg',
    appId: '1:865048516973:android:0e938f3bf5343b56b46264',
    messagingSenderId: '865048516973',
    projectId: 'todo-app-af635',
    storageBucket: 'todo-app-af635.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALIBwxbi3tMLuX-NfCpagc4Xm1mW2rvmA',
    appId: '1:865048516973:ios:273d32f167d11959b46264',
    messagingSenderId: '865048516973',
    projectId: 'todo-app-af635',
    storageBucket: 'todo-app-af635.appspot.com',
    iosClientId: '865048516973-8uaur7khru17do556344dmr5p54gkqma.apps.googleusercontent.com',
    iosBundleId: 'com.example.toDo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALIBwxbi3tMLuX-NfCpagc4Xm1mW2rvmA',
    appId: '1:865048516973:ios:273d32f167d11959b46264',
    messagingSenderId: '865048516973',
    projectId: 'todo-app-af635',
    storageBucket: 'todo-app-af635.appspot.com',
    iosClientId: '865048516973-8uaur7khru17do556344dmr5p54gkqma.apps.googleusercontent.com',
    iosBundleId: 'com.example.toDo',
  );
}
