import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_school_web/app/helpers/app_colors.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myInputWidget.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myTableView.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:stacked/stacked.dart';

import 'notification.view.model.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      onModelReady: (model) {
        // Do something once your model is initialized
        model.init();
        model.onRefresh();
      },
      builder: (
        BuildContext context,
        NotificationViewModel model,
        Widget child,
      ) {
        return SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
          if (model.isAddElementVisible)
            Card(
              elevation: 1,
              shadowColor: Colors.black,
              clipBehavior: Clip.none,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Send Notificaiton",
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
                  SizedBox(
                    height: 600,
                    width: 800,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Send Through"),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 450,
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                      title: Text("Phone Notification"),
                                      value: model.viaFCM,
                                      onChanged: (bool val) {
                                        model.viaFCM = val;
                                        model.notifyListeners();
                                      }),
                                  CheckboxListTile(
                                      title: Text("Email"),
                                      value: model.viaEmail,
                                      onChanged: (bool val) {
                                        model.viaEmail = val;
                                        model.notifyListeners();
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 450,
                              child: TextFormField(
                                controller: model.titleController,
                                decoration: InputDecoration(
                                  hintText: "Title *",
                                  labelText: "Title",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 450,
                                height: 300,
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 100,
                                  controller: model.messageController,
                                  decoration: InputDecoration(
                                    hintText: "Write Your Message Here ...",
                                    labelText: "Message",
                                    border: OutlineInputBorder(),
                                  ),
                                )),
                          ],
                        ),
                        new SizedBox(
                          width: 50.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                              width: 3.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 300,
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItem: true,
                                items: ["all_teachers", "all_students", "all_parents"],
                                label: "Add Destination",
                                onChanged: (value) {
                                  if (!model.selectedItems.contains(value)) {
                                    model.selectedItems.add(value);
                                    model.notifyListeners();
                                  }
                                },
                              ),
                            ),
                            new SizedBox(
                              height: 50.0,
                              width: 100.0,
                              child: new Center(
                                child: new Container(
                                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                                  height: 3.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              height: 400,
                              child: Card(
                                elevation: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: model.selectedItems.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(model.selectedItems.elementAt(index)),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            model.selectedItems.removeAt(index);
                                            model.notifyListeners();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
            )
          else
            Container(),
          Card(
            elevation: 1,
            shadowColor: Colors.black,
            clipBehavior: Clip.none,
            child: Column(
              children: [
                PageHeader(),
                // Card(
                //   elevation: 15,
                //   child: sendNotification(),
                // ),
                MyTableView(
                  isLoading: model.isLoading,
                  source: model.source,
                  headers: model.headers,
                  onRefresh: model.onRefresh,
                  onCreateNew: model.onCreateNew,
                  onEdit: null,
                  onDelete: model.onDelete,
                  onSearch: model.onSearch,
                ),
              ],
            ),
          ),
        ]));
      },
    );
  }
}
