import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked_services/stacked_services.dart';

class ClassRoomViewModel extends BaseViewModel {
  // services
  final ClassRoomService currentService = locator<ClassRoomService>();
  final AuthService authService = locator<AuthService>();
  ClassRoomModel currentModel = new ClassRoomModel();

  // edit line widget to add or edit data
  TextEditingController roomNameController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  //tableview needs this variables
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = false;
  bool isAddElementVisible = false;
  List<DatatableHeader> headers = [
    DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
    DatatableHeader(text: "Room Number", value: "room_number", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Capacity", value: "capacity", show: true, sortable: true, textAlign: TextAlign.left),
  ];

  onRefresh() async {
    isLoading = true;
    notifyListeners();
    Response response = await currentService.getAll();
    if (response.statusCode == 200) {
      source.clear();

      currentService.list.forEach((element) {
        source.add({
          "ID": element.id,
          "room_number": element.room_number,
          "capacity": element.capacity,
          "Action": element.id,
        });
      });
    }
    isLoading = false;
    notifyListeners();
  }

  onCreateNew() async {
    var now = new DateTime.now();
    String random = now.millisecondsSinceEpoch.toString();
    currentModel.id = null;
    roomNameController.text = random;
    capacityController.text = random;
    isAddElementVisible = true;
    notifyListeners();
  }

  onValid() async {
    currentModel.room_number = roomNameController.text;
    currentModel.capacity = int.parse(capacityController.text);
    if (currentModel.id == null) {
      await currentService.add(currentModel);
    } else {
      await currentService.update(currentModel);
    }
    await onRefresh();
    await onCancel();
  }

  onCancel() async {
    currentModel.id = null;
    roomNameController.text = "";
    capacityController.text = "";
    isAddElementVisible = false;
    notifyListeners();
  }

  onEdit(id) async {
    currentModel = currentService.list.firstWhere((element) => element.id == id);
    roomNameController.text = currentModel.room_number;
    capacityController.text = currentModel.capacity.toString();
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
      await currentService.delete(ClassRoomModel(id: id));
      await onRefresh();
    }
  }

  onSearch(query) async {
    print(query);
    var ltm = currentService.list.where((element) {
      if (element.capacity == query || element.room_number.contains(query)) {
        return true;
      }
      return false;
    });
    source.clear();
    ltm.forEach((element) {
      source.add({
        "ID": element.id,
        "room_number": element.room_number,
        "capacity": element.capacity,
      });
    });
    notifyListeners();
  }
}
