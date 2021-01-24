import 'dart:math';

import 'package:my_school_web/common/common.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ParentsViewModel extends BaseViewModel {
  final ParentService parentService = locator<ParentService>();
  final AuthService authService = locator<AuthService>();
  List<ParentModel> listParentModel;
  ParentsViewModel() {}

  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = true;

  List<DatatableHeader> headers = [
    DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
    // DatatableHeader(text: "Roll No.", value: "Roll No.", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Full Name", value: "Full Name", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "children", value: "children", show: true, sortable: true, textAlign: TextAlign.left),
    // DatatableHeader(text: "Street Address", value: "Street Address", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Phone", value: "Phone", show: true, sortable: true, textAlign: TextAlign.left),
  ];

  onRefresh() async {
    isLoading = true;
    notifyListeners();

    Response response = await parentService.getAll();

    if (response.statusCode == 200) {
      listParentModel = parentService.list;
      source.clear();

      listParentModel.forEach((element) {
        String childrenNames = "";
        if (element.children != null) {
          element.children.forEach((child) {
            childrenNames += child.name.toString() + " , ";
          });
          if (childrenNames.isNotEmpty) childrenNames = childrenNames.substring(0, childrenNames.length - 2);
        }

        source.add({
          "ID": element.id,
          // "Roll No.": "element.rollNo",
          "Full Name": element.name,
          "children": childrenNames,
          // "Street Address": "element.street_address",
          "Phone": element.phone,
          "Action": element.id
        });
      });
    }

    isLoading = false;
    notifyListeners();
  }

  onCreateNew() async {
    await locator<StudentService>().getAll();
    await locator<NavigationService>().navigateTo(Routes.addParentView);
    onRefresh();
  }

  onEdit(id) async {
    ParentModel tm = listParentModel.firstWhere((element) => element.id == id);
    await locator<NavigationService>().navigateTo(Routes.addParentView, arguments: tm);
    await onRefresh();
  }

  onDelete(id) async {
    final _bottomSheetService = locator<BottomSheetService>();
    var response = await _bottomSheetService.showBottomSheet(
        title: "Are you sure you want delete this record ?",
        description: "click on Yes to confirm suppresion of the record",
        confirmButtonTitle: "YES",
        cancelButtonTitle: "NO");
    if (response == null) return;
    if (response.confirmed) {
      await parentService.delete(ParentModel(id: id));
      await onRefresh();
    }
  }

  onSearch(query) async {
    isLoading = true;
    notifyListeners();
    Iterable<ParentModel> ltm = listParentModel.where((element) {
      if (element.name.contains(query) ||
          // element.middle_name.contains(query) ||
          // element.last_name.contains(query) ||
          // element.phone.contains(query) ||
          // element.first_name.contains(query) ||
          // element.first_name.contains(query) ||
          // element.first_name.contains(query) ||
          element.phone.contains(query)) {
        return true;
      }
      return false;
    });
    source.clear();
    ltm.forEach((element) {
      source.add({
        "ID": element.id,
        "Roll No.": "element.rollNo",
        "Full Name": element.name,
        "Parent": "element.parent_id",
        "Street Address": "element.street_address",
        "Phone": element.phone,
        "Action": element.id
      });
    });
    // source.addAll(_generateData(n: 1000));
    isLoading = false;
    notifyListeners();
  }
}
