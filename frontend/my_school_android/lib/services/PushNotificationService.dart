import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class PushNotificationService {
  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }


  }
}
