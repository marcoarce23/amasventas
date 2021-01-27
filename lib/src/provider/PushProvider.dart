import 'dart:io';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  final prefs = new Preferense();

  initNotifications() {
    _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      alert: true,
      badge: true,
    ));
    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      prefs.token = token;
      print('tokennnn: ${prefs.token}');
    });

    // ignore: missing_return
    _firebaseMessaging.configure(onMessage: (info) {
      print('======= On Message ========');
      print(info);
      // info.

      String argumento = 'no-data';
      if (Platform.isAndroid) {
        argumento = info['notification']['body'] ?? 'no-data';
        //print('aaaaaa: ${ info['data']['ayudaPersona']}');
      } else {
        argumento = info['ayudaPersona'] ?? 'no-data-ios';
      }

      _mensajesStreamController.sink.add(argumento);
      // ignore: missing_return
    }, onLaunch: (info) {
      print('======= On Launch ========');
      print(info);

      String argumento = 'no-data';

      if (Platform.isAndroid) {
        argumento = info['notification']['body'] ?? 'no-data';
        //print('aaaaaa: ${ info['data']['ayudaPersona']}');
      } else {
        argumento = info['ayudaPersona'] ?? 'no-data-ios';
      }
      _mensajesStreamController.sink.add(argumento);
      // ignore: missing_return
    }, onResume: (info) {
      print('======= On Resume ========');
      print(info);
      String argumento = 'no-data';

      if (Platform.isAndroid) {
        argumento = info['notification']['body'] ?? 'no-data';
      } else {
        argumento = info['ayudaPersona'] ?? 'no-data-ios';
      }

      _mensajesStreamController.sink.add(argumento);
    });
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
