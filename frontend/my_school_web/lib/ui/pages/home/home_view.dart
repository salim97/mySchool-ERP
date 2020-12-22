import 'package:auto_route/auto_route.dart';
import 'package:my_school_web/app/router.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/ui/widgets/navbar/navigation_bar.dart';
import 'package:my_school_web/ui/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/router.gr.dart' as auto_router;
import 'package:stacked_services/stacked_services.dart';

class HomeView extends StatelessWidget {
  // final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _key,
      backgroundColor: Colors.white,
      drawer: Container(
        color: Colors.white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text("abc@gmail.com"),
              accountName: Text("Santos Enoque"),
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
                    initialRoute: auto_router.Routes.dashboardView,
                    // initialRoute: "Dashboard",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
