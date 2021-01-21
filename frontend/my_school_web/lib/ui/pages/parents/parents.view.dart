import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/common/common.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myTableView.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked/stacked.dart';

import 'parents.view.model.dart';

class ParentsView extends StatefulWidget {
  @override
  _ParentsViewState createState() => _ParentsViewState();
}

class _ParentsViewState extends State<ParentsView> {
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
          // model.onRefresh();
        },
        builder: (context, model, child) {
          return SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
            PageHeader(),
            MyTableView(
              source: model.source,
              headers: model.headers,
              onRefresh: model.onRefresh,
              onCreateNew: model.onCreateNew,
              onEdit: model.onEdit,
              onDelete: model.onDelete,
              onSearch: model.onSearch,
              isLoading: model.isLoading,
            ),
          ]));
        });
  }
}
