import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/responsive_table.dart';

class MyTableView extends StatefulWidget {
  final List<Map<String, dynamic>> source;
  final List<DatatableHeader> headers;
  final VoidCallback onRefresh;
  final VoidCallback onCreateNew;
  final Function(String) onSearch;
  final Function(dynamic) onEdit;
  final Function(dynamic) onDelete;
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
    // TODO: implement initState
    super.initState();
    widget.headers.add(DatatableHeader(
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
                icon: Icon(Icons.edit),
                onPressed: () async {
                  await widget.onEdit(value);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await widget.onDelete(value);
                },
              )
            ],
          ),
        );
      },
      textAlign: TextAlign.center,
    ));
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    print(widget.source);
    return Container(
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
          title: !isSearch
              ? Row(
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
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
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
                        "Create New",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    )
                  ],
                )
              : null,
          actions: [
            if (isSearch)
              Expanded(
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
              )),
            if (!isSearch)
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  })
          ],
          headers: widget.headers,
          source: widget.source,
          selecteds: selecteds,
          showSelect: showSelect,
          autoHeight: false,
          onTabRow: (data) {
            print(data);
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
            print("$value  $item ");
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
    );
  }
}
