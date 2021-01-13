import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/common/common.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myInputWidget.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myTableView.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'timeTable.view.model.dart';

class TimeTableView extends StatefulWidget {
  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<TimeTableViewModel>.reactive(
      viewModelBuilder: () => TimeTableViewModel(),
      onModelReady: (model) {
        // Do something once your model is initialized
        model.onRefresh();
      },
      builder: (context, model, child) {
        return SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
          model.isAddElementVisible
              ? Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(0),
                  child: Card(
                    elevation: 1,
                    shadowColor: Colors.black,
                    clipBehavior: Clip.none,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Create Class Routine",
                                style: TextStyle(fontSize: 24.0),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: DropdownSearch<TeacherSubjectModel>(
                                maxHeight: 300,
                                selectedItem: model.teacherSubjectModel_subject,
                                items: model.teacherSubjectService.list,
                                itemAsString: (TeacherSubjectModel u) => u.subjectid?.name ?? "null",
                                label: "Select Subject*",
                                onChanged: (item) async {
                                  model.teacherSubjectModel_subject = item;
                                  model.notifyListeners();
                                },
                                showSearchBox: true,
                              ),
                            ),
                            Flexible(
                              child: DropdownSearch<TeacherSubjectModel>(
                                maxHeight: 300,
                                selectedItem: model.teacherSubjectModel_teacher,
                                items: model.teacherSubjectService.list,
                                // items: model.teacherSubjectService.list
                                //     .where((element) => element.subjectid.id == model.teacherSubjectModel_subject.subjectid.id)
                                //     .toList(),
                                itemAsString: (TeacherSubjectModel u) => u.teacherid?.name ?? "null",
                                label: "Teacher*",
                                onChanged: (item) async {
                                  model.teacherSubjectModel_teacher = item;
                                  model.notifyListeners();
                                },
                                showSearchBox: true,
                              ),
                            ),
                            Flexible(
                              child: DropdownSearch<ClassRoomModel>(
                                maxHeight: 300,
                                // selectedItem: model.classRoomService.list,
                                items: model.classRoomService.list,
                                itemAsString: (ClassRoomModel u) => u.room_number,
                                label: "Select Room*",
                                onChanged: (item) async {
                                  model.classRoomModel = item;
                                  model.notifyListeners();
                                },
                                showSearchBox: true,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton.icon(
                                onPressed: () {
                                  model.onCancel();
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton.icon(
                                onPressed: () {
                                  model.onValid();
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "valid",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          PageHeader(
            text: appProvider.currentPage,
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(0),
            child: Card(
              elevation: 1,
              shadowColor: Colors.black,
              clipBehavior: Clip.none,
              child: Column(
                children: [
                  Row(
                    children: [
                      RaisedButton.icon(
                        onPressed: () {
                          model.onRefresh();
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Refresh",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          model.onCreateNew();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Create New",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      )
                    ],
                  ),
                  Table(
//          defaultColumnWidth:
//              FixedColumnWidth(MediaQuery.of(context).size.width / 3),
                    border: TableBorder.all(color: Colors.black26, width: 1, style: BorderStyle.none),
                    children: model.listTableRow,
                  ),
                ],
              ),
            ),
          )
        ]));
      },
    );
  }
}
