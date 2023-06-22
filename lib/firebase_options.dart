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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA7mpszWDfH05fOiYJej9MVPPdphP40LvQ',
    appId: '1:824668856694:web:16600653ac5a4bda6ada57',
    messagingSenderId: '824668856694',
    projectId: 'beta-7e0a8',
    authDomain: 'beta-7e0a8.firebaseapp.com',
    storageBucket: 'beta-7e0a8.appspot.com',
    measurementId: 'G-ZMJVENZZXY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACPusOKlnKcP8Q_u-7XpkjHwkMj2W_49o',
    appId: '1:824668856694:android:b5f7f5597191c89e6ada57',
    messagingSenderId: '824668856694',
    projectId: 'beta-7e0a8',
    storageBucket: 'beta-7e0a8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnsSEKbFyLstwnZtRnIJPl6zlMTVeXh4c',
    appId: '1:824668856694:ios:00078172e3af7cec6ada57',
    messagingSenderId: '824668856694',
    projectId: 'beta-7e0a8',
    storageBucket: 'beta-7e0a8.appspot.com',
    iosBundleId: 'com.beta.betaDoctor',
  );
}
