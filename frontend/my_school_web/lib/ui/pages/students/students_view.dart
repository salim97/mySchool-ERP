import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myTableView.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked/stacked.dart';

import 'students_view_model.dart';

class StudentsView extends StatefulWidget {
  @override
  _StudentsViewState createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<StudentsViewModel>.reactive(
        viewModelBuilder: () => StudentsViewModel(),
        onModelReady: (model) {
          // Do something once your model is initialized
          model.onRefresh();
        },
        builder: (context, model, child) {
          return SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
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
