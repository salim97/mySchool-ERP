import 'dart:math';

import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
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

class TeachersViewModel extends BaseViewModel {
  final TeacherService teacherService = locator<TeacherService>();
  final AuthService authService = locator<AuthService>();
  List<TeacherModel> listTeacherModel;
  TeachersViewModel() {}

  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = true;

  List<DatatableHeader> headers = [
    DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
    DatatableHeader(text: "Employee Code", value: "Employee_Code", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Name", value: "Name", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(text: "Incharge Class", value: "Incharge_Class", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(text: "Subjects Handling", value: "Subjects_Handling", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(text: "Phone", value: "Phone", show: true, sortable: true, textAlign: TextAlign.center),
  ];

  onRefresh() async {
    isLoading = true;
    notifyListeners();
    Response response = await teacherService.getAll();
    if (response.statusCode == 200) {
      listTeacherModel = teacherService.listStudentModel;
      source.clear();
      listTeacherModel.forEach((element) {
        source.add({
          "ID": element.id,
          "Employee_Code": element.employee_code,
          "Name": element.name,
          "Incharge_Class": element.incharge_class,
          "Subjects_Handling": element.subjects_handling,
          "Phone": element.phone,
          "Action": element.id
        });
      });
    }

    // source.addAll(_generateData(n: 1000));
    isLoading = false;
    notifyListeners();

    // Future.delayed(Duration(seconds: 0)).then((value) async {

    // });
  }

  onCreateNew() async {
    await locator<NavigationService>().navigateTo(Routes.addTeacherView);
    onRefresh();
  }

  onEdit(id) async {
    TeacherModel tm = listTeacherModel.firstWhere((element) => element.id == id);
    await locator<NavigationService>().navigateTo(Routes.addTeacherView, arguments: tm);
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
      await teacherService.delete(TeacherModel(id: id));
      await onRefresh();
    }
  }

  onSearch(query) async {
    isLoading = true;
    notifyListeners();
    Iterable<TeacherModel> ltm = listTeacherModel.where((element) {
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
        "Employee_Code": element.employee_code,
        "Name": element.name,
        "Incharge_Class": element.incharge_class,
        "Subjects_Handling": element.subjects_handling,
        "Phone": element.phone,
        "Action": element.id
      });
    });
    // source.addAll(_generateData(n: 1000));
    isLoading = false;
    notifyListeners();
  }
}
