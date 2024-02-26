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
    apiKey: 'AIzaSyCVpyUcT85_lIAVnSRTSJTnODCQ_y3A7t4',
    appId: '1:1078983616450:web:38bf3cca8546b8d2cad85b',
    messagingSenderId: '1078983616450',
    projectId: 'translink-app-43f28',
    authDomain: 'translink-app-43f28.firebaseapp.com',
    storageBucket: 'translink-app-43f28.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsKbIBHTaV9XAOVGqDgWviNEbodNydW8s',
    appId: '1:1078983616450:android:97e8bb7e0de19caecad85b',
    messagingSenderId: '1078983616450',
    projectId: 'translink-app-43f28',
    storageBucket: 'translink-app-43f28.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArdRhDrqpVR2bOqY-Ut-LmL1oPevAVDhw',
    appId: '1:1078983616450:ios:1c4fac552c164161cad85b',
    messagingSenderId: '1078983616450',
    projectId: 'translink-app-43f28',
    storageBucket: 'translink-app-43f28.appspot.com',
    iosBundleId: 'com.example.translinkApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyArdRhDrqpVR2bOqY-Ut-LmL1oPevAVDhw',
    appId: '1:1078983616450:ios:2e18f14f676a7b3ccad85b',
    messagingSenderId: '1078983616450',
    projectId: 'translink-app-43f28',
    storageBucket: 'translink-app-43f28.appspot.com',
    iosBundleId: 'com.example.translinkApp.RunnerTests',
  );
}
