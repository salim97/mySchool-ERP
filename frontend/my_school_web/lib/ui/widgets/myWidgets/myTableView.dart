import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:my_school_web/theme.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/responsive_table.dart';

class MyTableView extends StatefulWidget {
  final List<Map<String, dynamic>> source;
  final List<DatatableHeader> headers;
  final VoidCallback onRefresh;
  final VoidCallback onCreateNew;
  final String createNewTitle;
  final Function(String) onSearch;
  final Function(dynamic) onEdit;
  final Function(dynamic) onDelete;
  // Function(dynamic) onDeleteAll;
  // Function(dynamic) onPrint;
  // Function(dynamic) onExport;
  // Function(dynamic) onImport;
  final bool isLoading;
  const MyTableView({
    Key key,
    this.source,
    this.headers,
    this.onRefresh,
    this.onCreateNew,
    this.onSearch,
    this.isLoading,
    this.onEdit,
    this.onDelete,
    this.createNewTitle = "Create New",
  }) : super(key: key);

  @override
  _MyTableViewState createState() => _MyTableViewState();
}

class _MyTableViewState extends State<MyTableView> {
  // List<int> _perPages = [5, 10, 15, 100];
  // int _total = 100;
  // int _currentPerPage;
  // int _currentPage = 1;

  bool isSearch = false;
  String sortColumn;
  bool sortAscending = true;
  bool showSelect = true;

  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();

  @override
  void initState() {
    super.initState();
    widget.headers.add(DatatableHeader(
      flex: 1,
      text: "Action",
      textAlign: TextAlign.right,
      value: "Action",
      show: true,
      sortable: false,
      sourceBuilder: (value, row) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.onEdit != null
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        await widget.onEdit(value);
                      },
                    )
                  : Container(),
              widget.onDelete != null
                  ? IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await widget.onDelete(value);
                      },
                    )
                  : Container(),
            ],
          ),
        );
      },
    ));
  }

  onDeleteAll() {
    var l = new Logger();
    l.d(selecteds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(0),
      constraints: BoxConstraints(
        maxHeight: 700,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              RaisedButton.icon(
                onPressed: () {
                  widget.onRefresh();
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                label: Text(
                  "Refresh",
                  style: Theme.of(context).textTheme.button,
                ),
                color: MyTheme.primary_button,
              ),
              SizedBox(
                width: 25,
              ),
              RaisedButton.icon(
                onPressed: () {
                  widget.onCreateNew();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  widget.createNewTitle,
                  style: Theme.of(context).textTheme.button,
                ),
                color: MyTheme.primary_button,
              ),
              Expanded(
                child: Container(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.23,
                child: TextField(
                  onChanged: widget.onSearch,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              isSearch = false;
                            });
                          }),
                      suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
                ),
              ),
            ],
          ),
          Expanded(
            child: Card(
              elevation: 1,
              shadowColor: Colors.black,
              clipBehavior: Clip.none,
              child: ResponsiveDatatable(
                headers: widget.headers,
                source: widget.source,
                selecteds: selecteds,
                showSelect: showSelect,
                autoHeight: false,
                
                onTabRow: (data) {
                  print(data);
                  FlutterClipboard.copy(data.toString()).then(( value ) => print('copied'));
                },
                onSort: (value) {
                  setState(() {
                    sortColumn = value;
                    sortAscending = !sortAscending;
                    if (sortAscending) {
                      widget.source.sort((a, b) => b[sortColumn].compareTo(a[sortColumn]));
                    } else {
                      widget.source.sort((a, b) => a[sortColumn].compareTo(b[sortColumn]));
                    }
                  });
                },
                sortAscending: sortAscending,
                sortColumn: sortColumn,
                isLoading: widget.isLoading,
                onSelect: (value, item) {
                  setState(() {
                    if (value) {
                      selecteds.add(item);
                    } else {
                      selecteds.removeAt(selecteds.indexOf(item));
                    }
                  });
                },
                onSelectAll: (value) {
                  setState(() {
                    if (value) {
                      selecteds = widget.source.map((entry) => entry).toList().cast();
                    } else {
                      selecteds.clear();
                    }
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              RaisedButton.icon(
                onPressed: () {
                  onDeleteAll();
                },
                icon: Icon(
                  MdiIcons.delete,
                  color: Colors.white,
                ),
                label: Text(
                  "Delete All",
                  style: Theme.of(context).textTheme.button,
                ),
                color: MyTheme.primary_button,
              ),
              Expanded(
                child: Container(),
              ),
              FlatButton(
                onPressed: () => {},
                padding: EdgeInsets.all(10.0),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(MdiIcons.import),
                    Text(
                      "Import",
                      style: Theme.of(context).textTheme.button.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => {},
                padding: EdgeInsets.all(10.0),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(MdiIcons.export),
                    Text(
                      "Export",
                      style: Theme.of(context).textTheme.button.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => {},
                padding: EdgeInsets.all(10.0),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(MdiIcons.printer),
                    Text(
                      "Print",
                      style: Theme.of(context).textTheme.button.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
