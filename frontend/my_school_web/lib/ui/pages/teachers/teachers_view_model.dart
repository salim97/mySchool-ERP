import 'dart:math';

import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TeachersViewModel extends BaseViewModel {
  final TeacherService teacherService = locator<TeacherService>();
  List<TeacherModel> listTeacherModel;
  TeachersViewModel() {}

  bool isSearch = false;
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool showSelect = true;
  bool isLoading = true;

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
          "Name": element.userAccount.name,
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

  onCreateNew() {
    locator<NavigationService>().navigateTo(Routes.addTeacherView);
  }

  onEdit(id) async {
    TeacherModel tm = listTeacherModel.firstWhere((element) => element.id == id);
    await locator<NavigationService>().navigateTo(Routes.addTeacherView, arguments: tm);
    await onRefresh();
  }

  onView(id) async {
    TeacherModel tm = listTeacherModel.firstWhere((element) => element.id == id);
    String description = "";
    description += "Full Name :" + tm.userAccount.name + "\n";
    description += "Date of birth :" + "tm?.date_of_birth" + "\n";
    description += "Phone Number :" + "tm?.phone" + "\n";
    description += "Position :" + "tm?.current_position" + "\n";
    description += "Address :" + "tm?.street_address" + "\n";
    description += "Joining Date :" + "tm?.joining_date" + "\n";
    description += "Working Hours :" + "tm?.working_hours" + "\n";
    description += "Gender :" + "tm?.gender" + "\n";
    description += "Email :" + "tm?.email_address" + "\n";
    description += "Blood Group :" + "tm?.blood_group" + "\n";
    description += "Qualification :" + " tm?.qualification" + "\n";
    description += "Leaving Date :" + "tm?.leaving_date" + "\n";
    description += "Employee Code :" + tm.employee_code + "\n";

    final _bottomSheetService = locator<BottomSheetService>();
    await _bottomSheetService.showBottomSheet(title: "INFO", description: description);
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
      teacherService.delete(id);
      onRefresh();
    }
  }

  onSearch(query) async {
    isLoading = true;
    notifyListeners();
    Iterable<TeacherModel> ltm = listTeacherModel.where((element) {
      if (element.userAccount.name.contains(query) ||
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
        "Name": element.userAccount.name,
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
