import 'package:my_school_web/ui/pages/login/login_view.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/provider/auth.dart';

import 'package:my_school_web/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'ui/pages/home/home_view.dart';
import './app/router.gr.dart' as auto_router;
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  dialogService.registerCustomDialogUi((context, dialogRequest) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height * 0.8,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.90), borderRadius: BorderRadius.all(Radius.circular(36)), boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 36),
          ]),
          child: dialogRequest.customData as Widget,
        ),
      ));
}

void main() {
  setupLocator();
  setupDialogUi();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider.init()),
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
  ], child:  MyApp()));
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
      // navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: auto_router.Routes.appPagesController,
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      // home: AppPagesController(),
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
        return  HomeView();
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
