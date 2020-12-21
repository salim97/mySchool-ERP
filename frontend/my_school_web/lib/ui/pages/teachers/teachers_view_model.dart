import 'dart:math';

import 'package:common/common.dart';
import 'package:my_school_web/app/locator.dart';
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

  TeachersViewModel() {}

  bool isSearch = false;
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool showSelect = true;
  bool isLoading = true;

  List<Map<String, dynamic>> _generateData({int n: 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    var i = source.length;
    print(i);

    for (var data in source) {
      temps.add({
        "ID": i,
        "Employee_Code": "$i\000$i",
        "Name": "teacher $i",
        "Incharge_Class": "class $i",
        "Subjects_Handling": "subjects $i",
        "Phone": "06$i",
        "Action": i
      });
      i++;
    }
    return temps;
  }

  onRefresh() async {
    isLoading = true;
    notifyListeners();
    List<TeacherModel> listTeacherModel = await teacherService.getAll();
    source.clear();
    listTeacherModel.forEach((element) {
      source.add({
        "ID": element.id,
        "Employee_Code": element.employee_code,
        "Name": element.first_name + " " + element.last_name,
        "Incharge_Class": element.incharge_class,
        "Subjects_Handling": element.subjects_handling,
        "Phone": element.phone,
        "Action": element.id
      });
    });
    // source.addAll(_generateData(n: 1000));
    isLoading = false;
    notifyListeners();

    // Future.delayed(Duration(seconds: 0)).then((value) async {

    // });
  }

  onCreateNew() {
    //appProvider.changeCurrentPage("addTeacher");
    // locator<NavigationService>().navigateTo("AddTeacherView");
  }
}
