import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myInputWidget.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myTableView.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'subject.view.model.dart';

class SubjectView extends StatefulWidget {
  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<SubjectViewModel>.reactive(
      viewModelBuilder: () => SubjectViewModel(),
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
                                "Add Subject",
                                style: TextStyle(fontSize: 24.0),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: MyInputWidget.userInputText(
                              title: "Subject Name",
                              textEditingController: model.nameController,
                            )),
                            Flexible(
                                child: MyInputWidget.userInputText(
                              title: "Subject Code",
                              textEditingController: model.codeController,
                            )),
                            Flexible(
                              child: DropdownSearch<String>(
                                maxHeight: 300,
                                selectedItem: model.currentModel.type ,
                                items: ["Theory", "Practical"],
                                label: "Subject Type*",
                                onChanged: (item) async {
                                  model.currentModel.type = item;
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
