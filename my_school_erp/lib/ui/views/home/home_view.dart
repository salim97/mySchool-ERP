library home_view;

import 'package:logger/logger.dart';
import 'package:my_school_erp/core/locator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'home_view_model.dart';
part 'home_mobile.dart';
part 'home_tablet.dart';
part 'home_desktop.dart';

class HomeView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) {
          // Do something once your model is initialized
        },
        builder: (context, model, child) {
          return ScreenTypeLayout(
            mobile: _HomeMobile(model),
            desktop: _HomeDesktop(model),
            tablet: _HomeTablet(model),
          );
        });
  }
}
