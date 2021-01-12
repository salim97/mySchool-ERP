import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked_services/stacked_services.dart';

class SectionViewModel extends BaseViewModel {
  // services
  final SectionService currentService = locator<SectionService>();
  final AuthService authService = locator<AuthService>();
  SectionModel currentModel = new SectionModel();

  // edit line widget to add or edit data
  TextEditingController nameController = TextEditingController();

  //tableview needs this variables
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = false;
  bool isAddElementVisible = false;
  List<DatatableHeader> headers = [
    DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
    DatatableHeader(text: "Section", value: "Section", show: true, sortable: true, textAlign: TextAlign.left),
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
          "Section": element.name,
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
    nameController.text = random;
    isAddElementVisible = true;
    notifyListeners();
  }

  onValid() async {
    currentModel.name = nameController.text;
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
    nameController.text = "";
    isAddElementVisible = false;
    notifyListeners();
  }

  onEdit(id) async {
    currentModel = currentService.list.firstWhere((element) => element.id == id);
    nameController.text = currentModel.name;
    isAddElementVisible = true;
    notifyListeners();
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
      await currentService.delete(SectionModel(id: id));
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
