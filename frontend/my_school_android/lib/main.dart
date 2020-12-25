import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import './app/router.gr.dart' as auto_router;
import 'app/locator.dart';
import 'app/theme.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: auto_router.Routes.splashView,
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      // home: AppPagesController(),
    );
  }
}