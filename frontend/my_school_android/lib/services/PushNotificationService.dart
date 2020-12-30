import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class PushNotificationService {
  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        var l = new Logger();
        l.d(message);
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        var l = new Logger();
        l.d(message);
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        var l = new Logger();
        l.d(message);
        print("onResume: $message");
      },
    );
  }
}
