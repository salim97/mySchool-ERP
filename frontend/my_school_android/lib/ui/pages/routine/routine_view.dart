import 'package:flutter/material.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:stacked/stacked.dart';

import 'routine_row.dart';
import 'routine_view_model.dart';

class RoutineView extends StatefulWidget {
  @override
  _RoutineViewState createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
    List<String> weeks_english = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'thursday',
    'Friday',
  ];
  List<String> weeks_french = [
    // 'Samedi',
    'Dimanche',
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    // 'Vendredi',
  ];
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoutineViewModel>.reactive(
      viewModelBuilder: () => RoutineViewModel(),
      builder: (
        BuildContext context,
        RoutineViewModel model,
        Widget child,
      ) {
    return Scaffold(
      appBar: AppBarWidget.header(context, 'Routine'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: weeks_french.length,
          itemBuilder: (context, index) {
            return RoutineRow(
              title: weeks_french[index],
              id: "0",
            );
          },
        ),
      ),
    );
      },
    );
  }
}