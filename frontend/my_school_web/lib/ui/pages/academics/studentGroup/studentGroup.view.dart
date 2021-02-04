import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_school_web/common/common.dart';
import 'package:my_school_web/theme.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:stacked/stacked.dart';

import 'studentGroup.view.model.dart';

class StudentGroupView extends StatefulWidget {
  @override
  _StudentGroupViewState createState() => _StudentGroupViewState();
}

class _StudentGroupViewState extends State<StudentGroupView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentGroupViewModel>.reactive(
      viewModelBuilder: () => StudentGroupViewModel(),
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
                                "Add Student to Group " + model.currentModel.name,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownSearch<StudentModel>(
                                        maxHeight: 300,
                                        selectedItem: model.currentStudentModel,
                                        items: model.fitlerListOfStudents,
                                        itemAsString: (StudentModel u) => u.name == null ? "" : u.name,
                                        label: "Select Student *",
                                        onChanged: (item) async {
                                          model.currentStudentModel = item;
                                          model.dropdownErrorStudentModel = null;
                                          model.notifyListeners();
                                        },
                                        showSearchBox: true,
                                      ),
                                    ),
                                    model.dropdownErrorStudentModel == null
                                        ? SizedBox.shrink()
                                        : Text(
                                            model.dropdownErrorStudentModel ?? "",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                  ],
                                ),
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
                                  try {
                                    await model.onValid();
                                  } catch (e) {
                                    print(e);
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
          PageHeader(),
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
                      SizedBox(
                        width: 300,
                        child: DropdownSearch<GroupModel>(
                          mode: Mode.MENU,
                          itemAsString: (GroupModel u) => u.section.name + " - " + u.name,
                          items: model.currentService.list.map((element) => element).toList(),
                          label: "Section - Group",
                          onChanged: (value) {
                            model.currentModel = value;
                            model.notifyListeners();
                            model.refreshList();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      model.currentModel.name == null
                          ? Container()
                          : RaisedButton.icon(
                              onPressed: () {
                                model.onCreateNew();
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: Text(
                                "ADD",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                            ),
                      // RaisedButton.icon(
                      //   onPressed: () {
                      //     model.onCreateNew();
                      //   },
                      //   icon: Icon(
                      //     Icons.add,
                      //     color: Colors.white,
                      //   ),
                      //   label: Text(
                      //     "Create New",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   color: Colors.blue,
                      // )
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
