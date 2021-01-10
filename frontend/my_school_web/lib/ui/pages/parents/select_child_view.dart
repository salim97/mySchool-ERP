import 'package:flutter/material.dart';
import 'package:my_school_web/common/common.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:stacked/stacked.dart';

import 'select_child_view_model.dart';

class SelectStudentView extends StatefulWidget {
  SelectStudentView({Key key}) : super(key: key);

  @override
  _SelectStudentViewState createState() => _SelectStudentViewState();
}

class _SelectStudentViewState extends State<SelectStudentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectStudentViewModel>.reactive(
        viewModelBuilder: () => SelectStudentViewModel(),
        onModelReady: (model) {
          model.onRefresh();
        },
        builder: (context, model, child) {
          List<DatatableHeader> headers = [
            DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
            DatatableHeader(text: "Roll No.", value: "Roll No.", show: true, sortable: true, textAlign: TextAlign.left),
            DatatableHeader(text: "Full Name", value: "Full Name", show: true, sortable: true, textAlign: TextAlign.center),
            DatatableHeader(text: "Street Address", value: "Street Address", show: true, sortable: true, textAlign: TextAlign.center),
            DatatableHeader(text: "Phone", value: "Phone", show: true, sortable: true, textAlign: TextAlign.center),
          ];

          return SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
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
                  title: !model.isSearch
                      ? Row(
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
                                model.onCancel();
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                            )
                          ],
                        )
                      : null,
                  actions: [
                    if (model.isSearch)
                      Expanded(
                          child: TextField(
                        onChanged: model.onSearch,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    model.isSearch = false;
                                  });
                                }),
                            suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
                      )),
                    if (!model.isSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              model.isSearch = true;
                            });
                          })
                  ],
                  headers: headers,
                  source: model.source,
                  selecteds: model.selecteds,
                  showSelect: model.showSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    model.onTapRow(data);
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
}
