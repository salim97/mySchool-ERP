import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:stacked/stacked.dart';
import 'working_hours_view_model.dart';
import 'package:intl/intl.dart';

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
          model.onRefresh();
        },
        viewModelBuilder: () => WorkingHoursViewModel(),
        builder: (context, model, child) {
          List<DatatableHeader> headers = [
            DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
            DatatableHeader(text: "Class Hour", value: "Class Hour", show: true, sortable: true, textAlign: TextAlign.left),
            DatatableHeader(text: "Begin Time", value: "Begin Time", show: true, sortable: true, textAlign: TextAlign.center),
            DatatableHeader(text: "End Time", value: "End Time", show: true, sortable: true, textAlign: TextAlign.center),
            DatatableHeader(text: "Type", value: "Type", show: true, sortable: true, textAlign: TextAlign.center),
            DatatableHeader(
                flex: 2,
                text: "Action",
                value: "Action",
                show: true,
                sortable: false,
                sourceBuilder: (value, row) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await model.onDelete(value);
                          },
                        )
                      ],
                    ),
                  );
                },
                textAlign: TextAlign.center),
          ];

          return SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
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
                        Flexible(child: userInputText(title: "Class Hour Name", textEditingController: model.classHourNameController)),
                        Flexible(child: userInputTime(title: "From", textEditingController: model.fromController)),
                        Flexible(child: userInputTime(title: "To", textEditingController: model.toController)),
                        Flexible(child: userInputText(title: "Type", textEditingController: model.typeController)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton.icon(
                        onPressed: () {
                          model.onCreateNew();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Add Hour",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxHeight: 700,
              ),
              child: Card(
                elevation: 1,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: ResponsiveDatatable(
                  headers: headers,
                  source: model.source,
                  selecteds: model.selecteds,
                  showSelect: model.showSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    model.sortColumn = value;
                    model.sortAscending = !model.sortAscending;
                    if (model.sortAscending) {
                      model.source.sort((a, b) => b[model.sortColumn].compareTo(a[model.sortColumn]));
                    } else {
                      model.source.sort((a, b) => a[model.sortColumn].compareTo(b[model.sortColumn]));
                    }
                    model.notifyListeners();
                  },
                  sortAscending: model.sortAscending,
                  sortColumn: model.sortColumn,
                  isLoading: model.isLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => model.selecteds.add(item));
                    } else {
                      setState(() => model.selecteds.removeAt(model.selecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      model.selecteds = model.source.map((entry) => entry).toList().cast();
                      model.notifyListeners();
                    } else {
                      model.selecteds.clear();
                      model.notifyListeners();
                    }
                  },
                ),
              ),
            ),
          ]));
        });
  }

  Widget userInputText(
      {String title,
      String hintText,
      TextEditingController textEditingController,
      bool mustFill = false,
      Function(String) onValidator = null,
      bool obscureText = false}) {
    if (hintText == null) hintText = title;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Text(title),
                  mustFill
                      ? Text(
                          " *",
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              )),
          TextFormField(
            obscureText: obscureText,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
            ),
            validator: mustFill == true
                ? onValidator == null
                    ? (value) {
                        if (value.isEmpty) {
                          return "Please provide a " + title;
                        }
                      }
                    : onValidator
                : null,
          )
        ],
      ),
    );
  }

  Widget userInputTime({
    String title,
    String hintText,
    TextEditingController textEditingController,
    bool mustFill = false,
  }) {
    if (hintText == null) hintText = title;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Text(title),
                  mustFill
                      ? Text(
                          " *",
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              )),
          DateTimeField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
            ),
            format: DateFormat("HH:mm"),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ],
      ),
    );
  }
}
