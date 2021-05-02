import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:my_school_android/app/costants.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:my_school_android/app/router.gr.dart';
import 'package:my_school_android/app_localizations.dart';
import 'package:my_school_android/ui/widgets/MyCardItem.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isTapped;
  int currentSelectedIndex;

  @override
  void initState() {
    super.initState();
    isTapped = false;
    // setState(() {
    //   _menu = Constants.menuStudent;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.handleStartUpLogic();
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: ListTile(
              leading: Image.asset(
                'assets/images/logo.png',
                width: 140.0,
              ),
              trailing: FloatingActionButton(
                onPressed: () {
                  locator<NavigationService>().navigateTo(Routes.profileView);
                },
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage("assets/images/unknown_profile.png"),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            flexibleSpace: Image(
              height: 200,
              image: AssetImage('assets/images/tool_bar_bg.png'),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
            elevation: 5.0,
          ),
          body: GridView.builder(
            itemCount: model.menu.keys.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              // var logger = new Logger();
              // logger.d(_menu);
              // print(_menu.keys.elementAt(index));
              // print(_menu.values.elementAt(index)["icon"]);
              return CustomWidget(
                index: index,
                isSelected: currentSelectedIndex == index,
                onSelect: () {
                  setState(() {
                    //currentSelectedIndex = index;
                    // final NavigationService _navigationService = locator<NavigationService>();
                    // _navigationService.replaceWith(Routes.homeView);
                  });
                  final NavigationService _navigationService = locator<NavigationService>();
                  _navigationService.navigateTo(model.menu.values.elementAt(index)["route name"]);
                },
                // headline: AppLocalizations.of(context).translate(_menu.keys.elementAt(index)),
                headline: AppLocalizations.of(context).translate(model.menu.keys.elementAt(index)),
                icon: model.menu.values.elementAt(index)["icon"],
              );
            },
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blueAccent, Colors.deepPurpleAccent])),
                    accountName: Text(
                      "Unknown User",
                      style: TextStyle(color: Colors.white),
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage("assets/images/unknown_profile.png"),
                      backgroundColor: Colors.transparent,
                    )),
                ListTile(
                  title: Text("Student Menu"),
                  onTap: () {
                    model.menu = Constants.menuStudent;
                    model.notifyListeners();

                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text("Teacher Menu"),
                  onTap: () {
                    model.menu = Constants.menuTeacher;
                    model.notifyListeners();

                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text("Admin Menu"),
                  onTap: () {
                    model.menu = Constants.menuAdmin;
                    model.notifyListeners();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  // selected: currentSelectedIndex == 3,
                  // selectedTileColor: Colors.lightBlue,
                  title: Text("Parent Menu"),
                  onTap: () {
                    model.menu = Constants.menuParent;
                    model.notifyListeners();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
