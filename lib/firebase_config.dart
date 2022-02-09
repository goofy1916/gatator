import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions? get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: "AIzaSyCo2nF_9R0lAjH-CtmxCmAtx1suAatwbu4",
        authDomain: "gatator-66e37.firebaseapp.com",
        databaseURL: "https://gatator-66e37.firebaseio.com",
        projectId: "gatator-66e37",
        storageBucket: "gatator-66e37.appspot.com",
        messagingSenderId: "306215569608",
        appId: "1:306215569608:web:bea303fcfeeabbcd7cfdfd",
        measurementId: "G-5S04CVLLDP",
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:448618578101:ios:cc6c1dc7a65cc83c',
        apiKey: 'AIzaSyCo2nF_9R0lAjH-CtmxCmAtx1suAatwbu4',
        projectId: 'react-native-firebase-testing',
        messagingSenderId: '448618578101',
        iosBundleId: 'com.invertase.testing',
        iosClientId:
            '448618578101-28tsenal97nceuij1msj7iuqinv48t02.apps.googleusercontent.com',
        androidClientId:
            '448618578101-a9p7bj5jlakabp22fo3cbkj7nsmag24e.apps.googleusercontent.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        storageBucket: 'react-native-firebase-testing.appspot.com',
      );
    } else {
      // Android
      log("Analytics Dart-only initializer doesn't work on Android, please make sure to add the config file.");

      return null;
    }
  }
}
