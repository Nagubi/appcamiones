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
    apiKey: 'AIzaSyDXAeb4faXJ-DuHkLn4IvBxw9k7jL8EZL4',
    appId: '1:87820298231:web:1372ca2a9057a0d2a970f2',
    messagingSenderId: '87820298231',
    projectId: 'appcamion-b044c',
    authDomain: 'appcamion-b044c.firebaseapp.com',
    storageBucket: 'appcamion-b044c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKgqpWjq4prx0dQxn42nP9XndWleBQfGA',
    appId: '1:87820298231:android:00c89c9c5787929ea970f2',
    messagingSenderId: '87820298231',
    projectId: 'appcamion-b044c',
    storageBucket: 'appcamion-b044c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQnAzHEYtNN0-5YGnfaWeP1329jRSF410',
    appId: '1:87820298231:ios:b5a610126f7e6ac8a970f2',
    messagingSenderId: '87820298231',
    projectId: 'appcamion-b044c',
    storageBucket: 'appcamion-b044c.appspot.com',
    iosClientId: '87820298231-9dkq4ob3cu81q46elh635m5jn458cpqj.apps.googleusercontent.com',
    iosBundleId: 'com.example.appcamiones',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBQnAzHEYtNN0-5YGnfaWeP1329jRSF410',
    appId: '1:87820298231:ios:a8ab499f29d01066a970f2',
    messagingSenderId: '87820298231',
    projectId: 'appcamion-b044c',
    storageBucket: 'appcamion-b044c.appspot.com',
    iosClientId: '87820298231-b3h4t1kgdc53s8rvi2so12pi1172t52b.apps.googleusercontent.com',
    iosBundleId: 'com.example.appcamiones.RunnerTests',
  );
}
