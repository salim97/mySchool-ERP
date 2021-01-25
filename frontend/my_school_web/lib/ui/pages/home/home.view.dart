import 'package:auto_route/auto_route.dart';
import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:my_school_web/app/router.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/ui/widgets/navbar/navigation_bar.dart';
import 'package:my_school_web/ui/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_school_web/app/router.gr.dart' as auto_router;
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../setup_dialog_ui.dart';
import 'home.view.model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String initialRoute = auto_router.Routes.dashboardView;

  @override
  void initState() {
    super.initState();
    setupDialogUi();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) async {
          final AuthService _authService = locator<AuthService>();
          await _authService.login(
            email: "admin@email.com",
            password: "azerty2020",
          );
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
            mobile: Scaffold(
              body:  mobile(),
            ),
            desktop: Scaffold(
              // key: _key,
              backgroundColor: Colors.white,

              body: Row(
                children: [
                  SideMenu(),
                  Expanded(
                    child: Column(
                      children: [
                        NavigationBar(),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(0),
                            child: Navigator(
                              key: locator<NavigationService>().navigatorKey,
                              // key: locator<DialogService>().navigatorKey,
                              onGenerateRoute: auto_router.Router().onGenerateRoute,
                              initialRoute: initialRoute,

                              // initialRoute: auto_router.Routes.addParentView
                              // initialRoute: auto_router.Routes.parentsView
                              // initialRoute: "Dashboard",
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget mobile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "for better user expirance we recommand to use android version of this app",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            child: RaisedButton(
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.android, color: Colors.white),
                  SizedBox(width: 5,),
                  Text("Available on the PlayStore", style: TextStyle(color: Colors.white),),
                ],
              ),
              onPressed: () {
                print("goto playstore");
              },
            ),
          ),
        )
      ],
    );
  }
}
