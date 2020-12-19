import 'package:my_school_web/pages/login/login_view.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/provider/auth.dart';

import 'package:my_school_web/rounting/router.dart';
import 'package:my_school_web/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/costants.dart';
import 'locator.dart';
import 'pages/home/home_view.dart';

void main() {
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider.init()),
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: "PageControllerRoute",
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
        return Loading();
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
