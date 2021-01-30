import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:my_school_web/theme.dart';
import 'package:my_school_web/ui/pages/login/login.view.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/provider/auth.provider.dart';

import 'package:my_school_web/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'setup_bottom_sheet_ui.dart';
import 'ui/pages/home/home.view.dart';
import './app/router.gr.dart' as auto_router;
import 'package:stacked_services/stacked_services.dart';
import 'setup_dialog_ui.dart';
import 'currentVersion.dart';
import 'ui/pages/splash/splash.view.dart';

const bool production = false;

void main() {
  print(currentVersion);
  setupLocator();
  // setupDialogUi();
  setupBottomSheetUi();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider.init()),
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: MyTheme.lightThemeData,
      dark: MyTheme.darkThemeData,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: auto_router.Routes.appPagesController,
        onGenerateRoute: auto_router.Router().onGenerateRoute,
      ),
    );
  }
}

class AppPagesController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    print(authProvider.status.toString());

    switch (authProvider.status) {
      case Status.Uninitialized:
        return SplashView();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginView();
      case Status.Authenticated:
        return HomeView();
      default:
        return LoginView();
    }

    //     );
    // return FutureBuilder(
    //   // Initialize FlutterFire:
    //   future: initialization,
    //   builder: (context, snapshot) {
    //     // Check for errors
    //     if (snapshot.hasError) {
    //       return Scaffold(
    //         body: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [Text("Something went wrong")],
    //         ),
    //       );
    //     }

    //     // Once complete, show your application
    //     if (snapshot.connectionState == ConnectionState.done) {

    //     }

    //     // Otherwise, show something whilst waiting for initialization to complete

    //   },
    // );
  }
}
