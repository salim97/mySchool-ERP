import 'package:my_school_web/rounting/router.dart';
import 'package:my_school_web/services/navigation_service.dart';
import 'package:my_school_web/widgets/navbar/navigation_bar.dart';
import 'package:my_school_web/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
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
                    onGenerateRoute: generateRoute,
                    initialRoute: "AddTeacherView",
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