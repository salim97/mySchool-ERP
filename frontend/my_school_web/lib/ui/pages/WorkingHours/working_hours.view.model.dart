import 'package:my_school_web/common/common.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

class WorkingHoursViewModel extends BaseViewModel {
  final WorkingHoursService workingHoursService = locator<WorkingHoursService>();
  List<WorkingHoursModel> listWorkingHoursModel;
  WorkingHoursViewModel() {}

  bool isSearch = false;
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool showSelect = true;
  bool isLoading = true;

  TextEditingController classHourNameController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  onRefresh() async {
    isLoading = true;
    notifyListeners();
    await workingHoursService.getAll();
    listWorkingHoursModel = workingHoursService.list;
    source.clear();
    listWorkingHoursModel.forEach((element) {
      source.add({
        "ID": element.id,
        "Class Hour": element.class_hour_name,
        "Begin Time": element.startTime,
        "End Time": element.endTime,
        "Type": element.type,
        "Action": element.id
      });
    });
    isLoading = false;
    notifyListeners();
  }

  onCreateNew() {
    //locator<NavigationService>().navigateTo(Routes.addTeacherView);
    workingHoursService.add(WorkingHoursModel(
      class_hour_name: classHourNameController?.text,
      startTime: fromController?.text,
      endTime: toController?.text,
      type: typeController?.text,
    ));
    onRefresh();
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
      workingHoursService.delete(id);
      onRefresh();
    }
  }
}
