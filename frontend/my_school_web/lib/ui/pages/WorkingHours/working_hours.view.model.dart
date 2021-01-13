import 'package:my_school_web/common/common.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

class WorkingHoursViewModel extends BaseViewModel {
  final WorkingHoursService currentService = locator<WorkingHoursService>();
  WorkingHoursModel currentModel = new WorkingHoursModel();
  WorkingHoursViewModel() {}

  TextEditingController classHourNameController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  List<DatatableHeader> headers = [
    DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
    DatatableHeader(text: "Class Hour", value: "Class Hour", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Begin Time", value: "Begin Time", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(text: "End Time", value: "End Time", show: true, sortable: true, textAlign: TextAlign.center),
    DatatableHeader(text: "Type", value: "Type", show: true, sortable: true, textAlign: TextAlign.center),
  ];

  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = false;
  bool isAddElementVisible = false;

  onRefresh() async {
    isLoading = true;
    notifyListeners();
    await currentService.getAll();
    source.clear();
    currentService.list.forEach((element) {
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

  onCreateNew() async {
    currentModel.id = null;
    isAddElementVisible = true;
    notifyListeners();
  }

  onValid() async {
    currentModel.class_hour_name = classHourNameController.text;
    currentModel.startTime = fromController.text;
    currentModel.endTime = toController.text;
    currentModel.type = typeController.text;

    if (currentModel.id == null) {
      currentService.add(currentModel);
    } else {
      currentService.update(currentModel);
    }
    await onRefresh();
    await onCancel();
  }

  onCancel() async {
    currentModel.id = null;
    classHourNameController.text = null;
    fromController.text = null;
    toController.text = null;
    typeController.text = null;
    
    isAddElementVisible = false;
    notifyListeners();
  }

  onEdit(id) async {
    currentModel = currentService.list.firstWhere((element) => element.id == id);
    classHourNameController.text = currentModel.class_hour_name;
    fromController.text = currentModel.startTime;
    toController.text = currentModel.endTime;
    typeController.text = currentModel.type;

    isAddElementVisible = true;
    notifyListeners();
    // await locator<NavigationService>().navigateTo(Routes.addStudentView, arguments: tm);
    // await onRefresh();
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
      await currentService.delete(WorkingHoursModel(id: id));
      await onRefresh();
    }
  }

  onSearch(query) async {
    print(query);
    // var ltm = currentService.list.where((element) {
    //   if (element.capacity == query || element.room_number.contains(query)) {
    //     return true;
    //   }
    //   return false;
    // });
    // source.clear();
    // ltm.forEach((element) {
    //   source.add({
    //     "ID": element.id,
    //     "room_number": element.room_number,
    //     "capacity": element.capacity,
    //   });
    // });
    notifyListeners();
  }
}
