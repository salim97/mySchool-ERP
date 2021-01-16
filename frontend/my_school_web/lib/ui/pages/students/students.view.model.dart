import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentsViewModel extends BaseViewModel {
  final StudentService studentService = locator<StudentService>();
  final AuthService authService = locator<AuthService>();
  List<StudentModel> listStudentModel;
  StudentsViewModel() {}

  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();

  bool isLoading = false;

  List<DatatableHeader> headers = [
    DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
    DatatableHeader(text: "Roll No.", value: "Roll No.", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Full Name", value: "Full Name", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Parent", value: "Parent", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Street Address", value: "Street Address", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Phone", value: "Phone", show: true, sortable: true, textAlign: TextAlign.left),
  ];

  onRefresh() async {
    isLoading = true;
    notifyListeners();
    Response response = await studentService.getAll();
    if (response.statusCode == 200) {
      listStudentModel = studentService.listStudentModel;
      source.clear();

      listStudentModel.forEach((element) {
        source.add({
          "ID": element.id,
          "Roll No.": element.rollNo,
          "Full Name": element.name,
          "Parent": element.parent_id,
          "Street Address": element.street_address,
          "Phone": element.phone,
          "Action": element.id
        });
      });
    }
    isLoading = false;
    notifyListeners();
  }

  onCreateNew() async {
    await locator<NavigationService>().navigateTo(Routes.addStudentView);
    onRefresh();
  }

  onEdit(id) async {
    StudentModel tm = listStudentModel.firstWhere((element) => element.id == id);
    await locator<NavigationService>().navigateTo(Routes.addStudentView, arguments: tm);
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
      await studentService.delete(StudentModel(id: id));
      await onRefresh();
    }
  }

  onSearch(query) async {
    print(query);
    Iterable<StudentModel> ltm = listStudentModel.where((element) {
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
        "Roll No.": element.rollNo,
        "Full Name": element.name,
        "Parent": element.parent_id,
        "Street Address": element.street_address,
        "Phone": element.phone,
        "Action": element.id
      });
    });
    notifyListeners();
  }
}
