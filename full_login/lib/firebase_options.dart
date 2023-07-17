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
    apiKey: 'AIzaSyDDl9AytJUoBAko6dtQ5ohcSAacbzrTHaI',
    appId: '1:195901942831:web:36b4f864be6de176936ada',
    messagingSenderId: '195901942831',
    projectId: 'full-login-akd',
    authDomain: 'full-login-akd.firebaseapp.com',
    storageBucket: 'full-login-akd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXRpkP8j3y3GtLnCNH1gVsH8h8B_KoxX8',
    appId: '1:195901942831:android:7a386dedc3b7d4b5936ada',
    messagingSenderId: '195901942831',
    projectId: 'full-login-akd',
    storageBucket: 'full-login-akd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD34OKlAw3VECeDhYS9YnAcRaSYdFigejU',
    appId: '1:195901942831:ios:6cbcd344ec08a27e936ada',
    messagingSenderId: '195901942831',
    projectId: 'full-login-akd',
    storageBucket: 'full-login-akd.appspot.com',
    iosClientId: '195901942831-vcop9m6hvbiqpbj662aealc9nq6eecpv.apps.googleusercontent.com',
    iosBundleId: 'com.example.fullLogin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD34OKlAw3VECeDhYS9YnAcRaSYdFigejU',
    appId: '1:195901942831:ios:7c3e00ac786642b7936ada',
    messagingSenderId: '195901942831',
    projectId: 'full-login-akd',
    storageBucket: 'full-login-akd.appspot.com',
    iosClientId: '195901942831-5ppoo2036rbugfiqc7856lkaf79e2426.apps.googleusercontent.com',
    iosBundleId: 'com.example.fullLogin.RunnerTests',
  );
}