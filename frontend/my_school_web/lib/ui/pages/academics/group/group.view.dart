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

import 'group.view.model.dart';

class GroupView extends StatefulWidget {
  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<GroupViewModel>.reactive(
      viewModelBuilder: () => GroupViewModel(),
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
                                "Add Class Room",
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
                                child: MyInputWidget.userInputText(
                              title: "Room name",
                              textEditingController: model.roomNameController,
                            )),
                            Flexible(
                              child: DropdownSearch<SectionModel>(
                                maxHeight: 300,
                                selectedItem: model.currentModel.section,
                                items: model.sectionService.list,
                                itemAsString: (SectionModel u) => u.name,
                                label: "Section*",
                                onChanged: (item) async {
                                  model.currentModel.section = item;
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
          PageHeader(),
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
