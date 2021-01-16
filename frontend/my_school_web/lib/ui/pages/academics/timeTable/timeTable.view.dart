import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_school_web/app/helpers/app_colors.dart';
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
                                style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,),
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                                onPressed: model.onCancel,
                              ),
                            ),
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
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ArgonButton(
                                height: 50,
                                width: 100,
                                borderRadius: 5.0,
                                borderSide: BorderSide(color: MyTheme.accents_check, width: 2.0),
                                color: Colors.white, //MyTheme.accents_check,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, //Center Row contents horizontally,
                                  crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,

                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: MyTheme.accents_check,
                                    ),
                                    Text(
                                      "valid",
                                      style: TextStyle(color: MyTheme.accents_check, fontSize: 18, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                loader: Container(
                                  padding: EdgeInsets.all(10),
                                  child: SpinKitRotatingCircle(
                                    color: MyTheme.accents_check,
                                    // size: loaderWidth ,
                                  ),
                                ),
                                onTap: (startLoading, stopLoading, btnState) async {
                                  startLoading();
                                  await Future.delayed(Duration(seconds: 1));
                                  try {
                                    await model.onValid();
                                  } catch (e) {
                                    stopLoading();
                                  }
                                  stopLoading();
                                },
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
