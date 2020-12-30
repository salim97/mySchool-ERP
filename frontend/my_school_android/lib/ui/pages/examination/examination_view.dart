import 'package:flutter/material.dart';
import 'package:my_school_android/app/costants.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:my_school_android/app_localizations.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:my_school_android/ui/widgets/MyCardItem.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'examination_view_model.dart';

class ExaminationView extends StatefulWidget {
  @override
  _ExaminationViewState createState() => _ExaminationViewState();
}

class _ExaminationViewState extends State<ExaminationView> {

    bool isTapped;
  int currentSelectedIndex;
  int rtlValue;

  Map _menu;

  @override
  void initState() {
    super.initState();
    isTapped = false;
    setState(() {
      _menu = Constants.menuExamination;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExaminationViewModel>.reactive(
      viewModelBuilder: () => ExaminationViewModel(),
      builder: (
        BuildContext context,
        ExaminationViewModel model,
        Widget child,
      ) {
        return Scaffold(
        appBar: AppBarWidget.header(context,'Examination'),
        backgroundColor: Colors.white,
        body: GridView.builder(
          itemCount: _menu.keys.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
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
                  _navigationService.navigateTo(_menu.values.elementAt(index)["route name"]);
                },
                // headline: AppLocalizations.of(context).translate(_menu.keys.elementAt(index)),
                headline: AppLocalizations.of(context).translate(_menu.keys.elementAt(index)),
                icon: _menu.values.elementAt(index)["icon"],
              );
          },
        ),
      );
      },
    );
  }
}