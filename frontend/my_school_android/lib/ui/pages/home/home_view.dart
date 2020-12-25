import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_school_android/app/costants.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:my_school_android/app/router.gr.dart';
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
  int rtlValue;

  @override
  void initState() {
    super.initState();
    isTapped = false;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
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
                width: 80.0,
              ),
              trailing: FloatingActionButton(
                onPressed: () {
                  print("zebi");
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
            itemCount: Constants.menuStudent.keys.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (context, index) {
              return CustomWidget(
                index: index,
                isSelected: currentSelectedIndex == index,
                onSelect: () {
                  setState(() {
                    currentSelectedIndex = index;
                    // final NavigationService _navigationService = locator<NavigationService>();
                    // _navigationService.replaceWith(Routes.homeView);
                  });
                  final NavigationService _navigationService = locator<NavigationService>();
                  _navigationService.navigateTo(Constants.menuStudent[Constants.menuStudent.keys.elementAt(index)]["route name"]);
                },
                headline: Constants.menuStudent.keys.elementAt(index),
                icon: Constants.menuStudent[Constants.menuStudent.keys.elementAt(index)]["icon"],
              );
            },
          ),
        );
      },
    );
  }
}
