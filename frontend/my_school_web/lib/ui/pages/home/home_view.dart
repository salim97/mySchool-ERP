import 'package:auto_route/auto_route.dart';
import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:my_school_web/app/router.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/ui/widgets/navbar/navigation_bar.dart';
import 'package:my_school_web/ui/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/router.gr.dart' as auto_router;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  // final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) async {
          // final AuthService _authService = locator<AuthService>();
          // await _authService.login(
          //   email: "admin@email.com",
          //   password: "azerty2020",
          // );

        },
        builder: (context, model, child) {
          return Scaffold(
            // key: _key,
            backgroundColor: Colors.white,
            drawer: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountEmail: Text("abc@gmail.com"),
                    accountName: Text("Nom Prenom"),
                  ),
                  ListTile(
                    title: Text("Lessons"),
                    leading: Icon(Icons.book),
                  )
                ],
              ),
            ),
            body: Row(
              children: [
                SideMenu(),
                Expanded(
                  child: Column(
                    children: [
                      NavigationBar(),
                      Expanded(
                        child: Navigator(
                            key: locator<NavigationService>().navigatorKey,
                            onGenerateRoute: auto_router.Router().onGenerateRoute,
                            initialRoute: auto_router.Routes.dashboardView
                            // initialRoute: auto_router.Routes.addParentView
                            // initialRoute: auto_router.Routes.parentsView
                            // initialRoute: "Dashboard",
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
