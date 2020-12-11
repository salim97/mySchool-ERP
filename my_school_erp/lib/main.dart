import 'package:stacked_services/stacked_services.dart';
import 'core/locator.dart';
import 'package:flutter/material.dart';
import 'ui/views/home/home_view.dart';
import 'core/route/router.gr.dart';



void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: HomeView(),
      initialRoute: Routes.homeView,
      onGenerateRoute: MyRouter().onGenerateRoute,
    );
  }
}
