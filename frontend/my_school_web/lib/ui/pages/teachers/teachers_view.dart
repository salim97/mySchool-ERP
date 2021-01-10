import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myTableView.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
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
          model.onRefresh();
        },
        builder: (context, model, child) {
          return SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
            PageHeader(
              text: appProvider.currentPage,
            ),
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
