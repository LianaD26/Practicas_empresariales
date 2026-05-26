import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Configuración automática de Firebase
/// Este archivo fue generado por FlutterFire CLI
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
    apiKey: 'AIzaSyCHVhvABeaYeHbvCJbRAdir4g7M7LdpRb4',
    appId: '1:905578771980:web:c1603a2c7d84854362a029',
    messagingSenderId: '905578771980',
    projectId: 'practicas-empresariales-49223',
    authDomain: 'practicas-empresariales-49223.firebaseapp.com',
    storageBucket: 'practicas-empresariales-49223.firebasestorage.app',
    measurementId: 'G-F6TD648V2F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9ZXUfVvGsx7Qr5j8YZDXTu09y11hhWlQ',
    appId: '1:905578771980:android:b46a6b47780a7f0a62a029',
    messagingSenderId: '905578771980',
    projectId: 'practicas-empresariales-49223',
    storageBucket: 'practicas-empresariales-49223.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm_jfxF8cCLy1eJP1Q3eqGMf7F6eN_vQ8',
    appId: '1:905578771980:ios:90937e5cf683c18762a029',
    messagingSenderId: '905578771980',
    projectId: 'practicas-empresariales-49223',
    storageBucket: 'practicas-empresariales-49223.firebasestorage.app',
    iosBundleId: 'com.example.proyectoFinalMovil',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCm_jfxF8cCLy1eJP1Q3eqGMf7F6eN_vQ8',
    appId: '1:905578771980:ios:90937e5cf683c18762a029',
    messagingSenderId: '905578771980',
    projectId: 'practicas-empresariales-49223',
    storageBucket: 'practicas-empresariales-49223.firebasestorage.app',
    iosBundleId: 'com.example.proyectoFinalMovil',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCHVhvABeaYeHbvCJbRAdir4g7M7LdpRb4',
    appId: '1:905578771980:web:87e44ce77dc8768162a029',
    messagingSenderId: '905578771980',
    projectId: 'practicas-empresariales-49223',
    authDomain: 'practicas-empresariales-49223.firebaseapp.com',
    storageBucket: 'practicas-empresariales-49223.firebasestorage.app',
    measurementId: 'G-1S2B5M55WX',
  );

}