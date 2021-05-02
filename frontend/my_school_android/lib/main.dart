import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import './app/router.gr.dart' as auto_router;
import 'app/locator.dart';
import 'app/theme.dart';
import 'app_localizations.dart';
import 'provider/app_provider.dart';
import 'setup_bottom_sheet_ui.dart';


void main() {
  setupLocator();
  setupBottomSheetUi();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppProvider.init()),
    ],
    child: MyApp(),
  ));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      initialRoute: auto_router.Routes.splashView,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      // home: AppPagesController(),
      locale: appProvider.locale,
      // List all of the app's supported locales here
      supportedLocales: [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).

        return supportedLocales.first;
      },
    );
  }
}
