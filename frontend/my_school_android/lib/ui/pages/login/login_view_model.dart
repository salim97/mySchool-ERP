import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:my_school_android/app/router.gr.dart';
import 'package:my_school_android/services/FirebaseRemoteConfig.dart';
import 'package:my_school_android/services/PushNotificationService.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  return LoginViewModel()._showNotification(message);
}

class LoginViewModel extends BaseViewModel {
  final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future selectNotification(String payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future _showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel desc',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'new message arived',
      'i want ${message['data']['title']} for ${message['data']['price']}',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  init() async {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);

    await _pushNotificationService.initialise();

    _pushNotificationService.fcm.configure(
        onBackgroundMessage: myBackgroundHandler,
      onMessage: (Map<String, dynamic> message) async {
        var l = new Logger();
        l.d(message);
        print("onMessage: $message");
        BottomSheetService bottomSheetService = locator<BottomSheetService>();
        var sheetResponse = await bottomSheetService.showBottomSheet(
          title: message["notification"]["title"],
          description: message["notification"]["body"],
        );
        if (sheetResponse != null) if (sheetResponse.confirmed) {
          await locator<NavigationService>().navigateTo(Routes.noticeView);
        }
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
    await _pushNotificationService.fcm.unsubscribeFromTopic("all_teachers");
    await _pushNotificationService.fcm.unsubscribeFromTopic("all_students");
    await _pushNotificationService.fcm.unsubscribeFromTopic("all_parent");
    emailController.text = "teacher@email.com";
    passwordController.text = "azerty2020";
  }

  var l = new Logger();
  onLoginClicked() async {
    String token = await _pushNotificationService.fcm.getToken();
    print("token");
    print(token);

    // final FirebaseRemoteConfig firebaseRemoteConfig = locator<FirebaseRemoteConfig>();
    // await firebaseRemoteConfig.synchroniseWithFirebase();
    // // _navigationService.replaceWith(Routes.homeView);
    // String fcm = firebaseRemoteConfig.backendURL;
    // print("backendURL= " + fcm);

    Response response = await _authService.login(
      fcm: token == null ? "" : token,
      email: emailController.text,
      password: passwordController.text,
    );

    if (_authService.userModel.role == "teacher") {
      await _pushNotificationService.fcm.subscribeToTopic('all_teachers');
    }
    if (_authService.userModel.role == "student") {
      await _pushNotificationService.fcm.subscribeToTopic('all_students');
    }
    if (_authService.userModel.role == "parent") {
      await _pushNotificationService.fcm.subscribeToTopic('all_parent');
    }
    await _navigationService.navigateTo(Routes.homeView);
    // l.d(response.statusCode);
    // l.d(_authService.userModel.toJson());
    // Future.delayed(Duration(seconds: 3), () async {
    //   Response r;

    //   r = await _authService.me();
    //   l.d(r.statusCode);

    //   r = await _authService.logout();
    //   l.d(r.statusCode);

    //   r = await _authService.me();
    //   l.d(r.statusCode);
    // });
    // l.d(response);
    // final AuthService authService = locator<AuthService>();
    // Map json = await authService.login(email: email, password: password);
    // var logger = Logger();

    // logger.d(json);
    // print(json);
//                             if(email.length > 5 && password.length > 5){
//                               setState(() {
//                                 isResponse = true;
//                               });
//                               Login(email, password).getData(context).then((result)=>{
// //                                if(result){
// //                                  debugPrint('success')
// //                                }
//                               });
//                             }else{
//                               setState(() {
//                                 isResponse = false;
//                               });
//                               Utils.showToast('invalid email and password');
//                             }
//                            setState(() {
//                              if (_formKey.currentState.validate()) {
//
//                                Utils.showToast('${emailController.text}  ${passwordController.text}');
//
//                                String email = emailController.text;
//                                String password = passwordController.text;
//
//                                debugPrint('$email  $password');
//
//                                Login(email, password).getData(context).then((result)=>{
//                                  if(result){
//                                    debugPrint('success')
//                                  }
//                                });
//                              }
//                            });
  }
}
