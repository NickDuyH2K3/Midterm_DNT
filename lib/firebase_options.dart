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
    apiKey: 'AIzaSyBD6nbl_V0ZzhxDtpc0-72dKkm6CuFBh4k',
    appId: '1:845368905098:web:9e15b8ad3c5e1279790c73',
    messagingSenderId: '845368905098',
    projectId: 'midterm-crud-2d29e',
    authDomain: 'midterm-crud-2d29e.firebaseapp.com',
    storageBucket: 'midterm-crud-2d29e.appspot.com',
    measurementId: 'G-SFY2T2MT68',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCv_lUiZOlmfkkbSDh0455CbF2NljEBLvY',
    appId: '1:845368905098:android:552f7dca8a26f47e790c73',
    messagingSenderId: '845368905098',
    projectId: 'midterm-crud-2d29e',
    storageBucket: 'midterm-crud-2d29e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUEKNXVdY9sYK5DsM2EgJwoiyDamMNQvQ',
    appId: '1:845368905098:ios:1df72b538e57a941790c73',
    messagingSenderId: '845368905098',
    projectId: 'midterm-crud-2d29e',
    storageBucket: 'midterm-crud-2d29e.appspot.com',
    iosBundleId: 'com.example.midternNguyenphuchung',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUEKNXVdY9sYK5DsM2EgJwoiyDamMNQvQ',
    appId: '1:845368905098:ios:1df72b538e57a941790c73',
    messagingSenderId: '845368905098',
    projectId: 'midterm-crud-2d29e',
    storageBucket: 'midterm-crud-2d29e.appspot.com',
    iosBundleId: 'com.example.midternNguyenphuchung',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBD6nbl_V0ZzhxDtpc0-72dKkm6CuFBh4k',
    appId: '1:845368905098:web:e8dbdfdc14f0675a790c73',
    messagingSenderId: '845368905098',
    projectId: 'midterm-crud-2d29e',
    authDomain: 'midterm-crud-2d29e.firebaseapp.com',
    storageBucket: 'midterm-crud-2d29e.appspot.com',
    measurementId: 'G-HD1V2SPK37',
  );

}