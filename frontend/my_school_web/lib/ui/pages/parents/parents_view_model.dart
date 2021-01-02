import 'dart:math';

import 'package:my_school_web/common/common.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
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

class ParentsViewModel extends BaseViewModel {
  final ParentService parentService = locator<ParentService>();
  final AuthService authService = locator<AuthService>();
  List<ParentModel> listParentModel;
  ParentsViewModel() {}

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

    Response response = await parentService.getAll();

    if (response.statusCode == 200) {
      listParentModel = parentService.listParentModel;
      source.clear();

      listParentModel.forEach((element) {
        source.add({
          "ID": element.id,
          "Roll No.": "element.rollNo",
          "Full Name": element.userAccount.name,
          "Parent": "element.parent_id",
          "Street Address": "element.street_address",
          "Phone": element.phone,
          "Action": element.id
        });
      });
    }

    isLoading = false;
    notifyListeners();

  }

  onCreateNew() async {
    await locator<NavigationService>().navigateTo(Routes.addParentView);
    onRefresh();
  }

  onEdit(id) async {
    ParentModel tm = listParentModel.firstWhere((element) => element.id == id);
    await locator<NavigationService>().navigateTo(Routes.addParentView, arguments: tm);
    await onRefresh();
  }

  onView(id) async {
    ParentModel tm = listParentModel.firstWhere((element) => element.id == id);
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
    description += "Employee Code :" + "tm.rollNo" + "\n";

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
      await parentService.delete(ParentModel(id: id));
      await onRefresh();
    }
  }

  
  onSearch(query) async {
    isLoading = true;
    notifyListeners();
    Iterable<ParentModel> ltm = listParentModel.where((element) {
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
        "Roll No.": "element.rollNo",
        "Full Name": element.userAccount.name ,
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
