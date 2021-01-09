import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:common/common.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked/stacked.dart';

import 'parents_view_model.dart';

class ParentsView extends StatefulWidget {
  @override
  _ParentsViewState createState() => _ParentsViewState();
}

class _ParentsViewState extends State<ParentsView> {
  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  int _currentPerPage;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<ParentsViewModel>.reactive(
        viewModelBuilder: () => ParentsViewModel(),
        onModelReady: (model) {
          // Do something once your model is initialized
          // model.authService = Provider.of<AppProvider>(context, listen: false).authService;
          // model.parentService = Provider.of<AppProvider>(context, listen: false).parentService;
          model.onRefresh();
        },
        builder: (context, model, child) {
          List<DatatableHeader> headers = [
            DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
            DatatableHeader(text: "Roll No.", value: "Roll No.", show: true, sortable: true, textAlign: TextAlign.left),
            DatatableHeader(text: "Full Name", value: "Full Name", show: true, sortable: true, textAlign: TextAlign.center),
            DatatableHeader(text: "Parent", value: "Parent", show: true, sortable: true, textAlign: TextAlign.center),
            DatatableHeader(text: "Street Address", value: "Street Address", show: true, sortable: true, textAlign: TextAlign.center),
            DatatableHeader(text: "Phone", value: "Phone", show: true, sortable: true, textAlign: TextAlign.center),
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
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () async {
                            await model.onView(value);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await model.onEdit(value);
                          },
                        ),
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
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Rows per page:"),
                    ),
                    if (_perPages != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                            value: _currentPerPage,
                            items: _perPages
                                .map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _currentPerPage = value;
                              });
                            }),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("$_currentPage - $_currentPerPage of $_total"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentPage = _currentPage >= 2 ? _currentPage - 1 : 1;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          _currentPage++;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    )
                  ],
                ),
              ),
            ),
          ]));
        });
  }
}
