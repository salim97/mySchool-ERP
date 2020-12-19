import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked/stacked.dart';

import 'teachers_view_model.dart';

class TeachersView extends StatefulWidget {
  @override
  _TeachersViewState createState() => _TeachersViewState();
}

class _TeachersViewState extends State<TeachersView> {
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

    return ViewModelBuilder<TeachersViewModel>.reactive(
        viewModelBuilder: () => TeachersViewModel(),
        onModelReady: (model) {
          // Do something once your model is initialized
          print("onModelReady");
          model.onRefresh();
        },
        builder: (context, model, child) {
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
                      ? RaisedButton.icon(
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
                      : null,
                  actions: [
                    if (model.isSearch)
                      Expanded(
                          child: TextField(
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
                  headers: model.headers,
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
