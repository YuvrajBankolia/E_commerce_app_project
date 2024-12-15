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
    apiKey: 'AIzaSyBEGUTHozJruG-Nz9u8FLOnavn5k4NMWYE',
    appId: '1:797633912357:web:fe68ab24c8b5ebd01f29cc',
    messagingSenderId: '797633912357',
    projectId: 'ecommerce-app-e6d9e',
    authDomain: 'ecommerce-app-e6d9e.firebaseapp.com',
    storageBucket: 'ecommerce-app-e6d9e.firebasestorage.app',
    measurementId: 'G-C748S662TZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlX-y4UhlmA4CThnjC0luT1bR3i0uQieg',
    appId: '1:797633912357:android:57ba641aa231c0a21f29cc',
    messagingSenderId: '797633912357',
    projectId: 'ecommerce-app-e6d9e',
    storageBucket: 'ecommerce-app-e6d9e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAgGNMIuH-QXCgY6T9bVVcDMQTbxa8L4M',
    appId: '1:797633912357:ios:08e9c839b244fee01f29cc',
    messagingSenderId: '797633912357',
    projectId: 'ecommerce-app-e6d9e',
    storageBucket: 'ecommerce-app-e6d9e.firebasestorage.app',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDAgGNMIuH-QXCgY6T9bVVcDMQTbxa8L4M',
    appId: '1:797633912357:ios:08e9c839b244fee01f29cc',
    messagingSenderId: '797633912357',
    projectId: 'ecommerce-app-e6d9e',
    storageBucket: 'ecommerce-app-e6d9e.firebasestorage.app',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBEGUTHozJruG-Nz9u8FLOnavn5k4NMWYE',
    appId: '1:797633912357:web:11eca51e19c8e4411f29cc',
    messagingSenderId: '797633912357',
    projectId: 'ecommerce-app-e6d9e',
    authDomain: 'ecommerce-app-e6d9e.firebaseapp.com',
    storageBucket: 'ecommerce-app-e6d9e.firebasestorage.app',
    measurementId: 'G-Y20VKXNG26',
  );
}
