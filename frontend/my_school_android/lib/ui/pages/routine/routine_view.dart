import 'package:flutter/material.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:stacked/stacked.dart';

import 'routine_view_model.dart';

class RoutineView extends StatefulWidget {
  @override
  _RoutineViewState createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoutineViewModel>.reactive(
      viewModelBuilder: () => RoutineViewModel(),
      onModelReady: (model) {
        model.init();
      },
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
            child: model.currentModel != null
                ? ListView.builder(
                    itemCount: model.days.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child: Text(model.currentModel.groupid.section.name + " - " + model.currentModel.groupid.name,
                                    style: Theme.of(context).textTheme.title.copyWith(fontSize: 15.0)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(model.days.elementAt(index), style: Theme.of(context).textTheme.title.copyWith(fontSize: 15.0)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text('Time', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                                  ),
                                  Expanded(
                                    child: Text('Subject', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                                  ),
                                  Expanded(
                                    child: Text('Room', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: model.currentModel.children.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index2) {
                                var oneTimeTable = model.currentModel.children.elementAt(index2);
                                return RoutineRowDesign(
                                  oneTimeTable.workingHoursModel.startTime + ' - ' + oneTimeTable.workingHoursModel.endTime,
                                  oneTimeTable.teacherSubjectModel.subjectid.name,
                                  oneTimeTable.classRoomModel.room_number,
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                height: 0.5,
                                decoration: BoxDecoration(
                                  color: Color(0xFF415094),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : Container(),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class RoutineRowDesign extends StatelessWidget {
  String time;
  String subject;
  String room;

  RoutineRowDesign(this.time, this.subject, this.room);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(time, style: Theme.of(context).textTheme.display1),
          ),
          Expanded(
            child: Text(subject, style: Theme.of(context).textTheme.display1),
          ),
          Expanded(
            child: Text(room, style: Theme.of(context).textTheme.display1),
          ),
        ],
      ),
    );
  }
}
