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
    apiKey: 'AIzaSyDh2PDIqzDglf57JMCHZw2w7IrKqoiU8dg',
    appId: '1:853396188271:web:1197d0b8cafa56b96f319a',
    messagingSenderId: '853396188271',
    projectId: 'gemini-chat-app-eb9b8',
    authDomain: 'gemini-chat-app-eb9b8.firebaseapp.com',
    storageBucket: 'gemini-chat-app-eb9b8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnBjuTeegn4KV6VDnwPtp70vyFYBUTgII',
    appId: '1:853396188271:android:c18f7f0b465a5f486f319a',
    messagingSenderId: '853396188271',
    projectId: 'gemini-chat-app-eb9b8',
    storageBucket: 'gemini-chat-app-eb9b8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYyAt5ewJnuJ3GGV-HhemQ3QsX_BlO-Mg',
    appId: '1:853396188271:ios:931232b32bec4ebd6f319a',
    messagingSenderId: '853396188271',
    projectId: 'gemini-chat-app-eb9b8',
    storageBucket: 'gemini-chat-app-eb9b8.appspot.com',
    iosBundleId: 'com.example.geminiChatBot',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYyAt5ewJnuJ3GGV-HhemQ3QsX_BlO-Mg',
    appId: '1:853396188271:ios:931232b32bec4ebd6f319a',
    messagingSenderId: '853396188271',
    projectId: 'gemini-chat-app-eb9b8',
    storageBucket: 'gemini-chat-app-eb9b8.appspot.com',
    iosBundleId: 'com.example.geminiChatBot',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDh2PDIqzDglf57JMCHZw2w7IrKqoiU8dg',
    appId: '1:853396188271:web:9d0014b19ab8d0706f319a',
    messagingSenderId: '853396188271',
    projectId: 'gemini-chat-app-eb9b8',
    authDomain: 'gemini-chat-app-eb9b8.firebaseapp.com',
    storageBucket: 'gemini-chat-app-eb9b8.appspot.com',
  );
}
