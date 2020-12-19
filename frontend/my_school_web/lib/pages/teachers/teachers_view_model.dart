import 'dart:math';

import 'package:common/common.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class TeachersViewModel extends BaseViewModel {
  final TeacherService teacherService = locator<TeacherService>();

  TeachersViewModel() {}

  List<DatatableHeader> headers = [
    DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
    DatatableHeader(text: "Employee Code", value: "Employee_Code", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Name", value: "Name", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(text: "Incharge Class", value: "Incharge_Class", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(text: "Subjects Handling", value: "Subjects_Handling", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(text: "Phone", value: "Phone", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(
        flex: 2,
        text: "Action",
        value: "Action",
        show: true,
        sortable: false,
        sourceBuilder: (value, row) {
          //List list = List.from(value);
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    print("kamok id = " + value.toString());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    print("kamok");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print("kamok");
                  },
                )
              ],
            ),
          );
        },
        textAlign: TextAlign.center),
  ];

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
    locator<NavigationService>().navigateTo("AddTeacherView");
  }
}
