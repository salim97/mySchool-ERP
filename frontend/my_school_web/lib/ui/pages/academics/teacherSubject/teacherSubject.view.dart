import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/common/common.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myInputWidget.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myTableView.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'teacherSubject.view.model.dart';

class TeacherSubjectView extends StatefulWidget {
  @override
  _TeacherSubjectViewState createState() => _TeacherSubjectViewState();
}

class _TeacherSubjectViewState extends State<TeacherSubjectView> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<TeacherSubjectViewModel>.reactive(
      viewModelBuilder: () => TeacherSubjectViewModel(),
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
                                "Assign Teacher to Subject",
                                style: TextStyle(fontSize: 24.0),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: DropdownSearch<TeacherModel>(
                                maxHeight: 300,
                                selectedItem: model.currentModel.teacherid,
                                items: model.teacherService.list,
                                itemAsString: (TeacherModel u) => u.name,
                                label: "Teacher Name*",
                                onChanged: (item) async {
                                  model.currentModel.teacherid = item;
                                  model.notifyListeners();
                                },
                                showSearchBox: true,
                              ),
                            ),
                            Flexible(
                              child: DropdownSearch<SubjectModel>(
                                maxHeight: 300,
                                selectedItem: model.currentModel.subjectid,
                                items: model.subjectService.list,
                                itemAsString: (SubjectModel u) => u.name,
                                label: "Subject Name*",
                                onChanged: (item) async {
                                  model.currentModel.subjectid = item;
                                  model.notifyListeners();
                                },
                                showSearchBox: true,
                              ),
                            )
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
          MyTableView(
            isLoading: model.isLoading,
            source: model.source,
            headers: model.headers,
            onRefresh: model.onRefresh,
            onCreateNew: model.onCreateNew,
            onEdit: model.onEdit,
            onDelete: model.onDelete,
            onSearch: model.onSearch,
          ),
        ]));
      },
    );
  }
}
