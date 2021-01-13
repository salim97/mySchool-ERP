import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myInputWidget.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myTableView.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:stacked/stacked.dart';
import 'working_hours.view.model.dart';

class WorkingHoursView extends StatefulWidget {
  @override
  _WorkingHoursViewState createState() => _WorkingHoursViewState();
}

class _WorkingHoursViewState extends State<WorkingHoursView> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<WorkingHoursViewModel>.reactive(
        onModelReady: (model) {
          // Do something once your model is initialized
          model.typeController.text = "Teaching";
          model.onRefresh();
        },
        viewModelBuilder: () => WorkingHoursViewModel(),
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
                                  "Class Hours",
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
                                      title: "Class Hour Name", textEditingController: model.classHourNameController)),
                              Flexible(child: MyInputWidget.userInputTime(title: "From", textEditingController: model.fromController)),
                              Flexible(child: MyInputWidget.userInputTime(title: "To", textEditingController: model.toController)),
                              Flexible(
                                child: DropdownSearch<String>(
                                  maxHeight: 150,
                                  selectedItem: model.typeController.text,
                                  items: ["Teaching", "Pause"],
                                  label: "Type*",
                                  onChanged: (item) async {
                                    model.typeController.text = item;
                                    model.notifyListeners();
                                  },
                                 mode: Mode.MENU,
                                //  validator: ,
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
        });
  }
}
