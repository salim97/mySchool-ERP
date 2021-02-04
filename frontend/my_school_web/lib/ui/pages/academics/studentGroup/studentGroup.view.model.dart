import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/common/common.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentGroupViewModel extends BaseViewModel {
  final GroupService currentService = locator<GroupService>();
  GroupModel currentModel = new GroupModel();

  final StudentService studentService = locator<StudentService>();
  StudentModel currentStudentModel;
  //tableview needs this variables
  bool isLoading = false;
  bool isAddElementVisible = false;

  onRefresh() async {
    isLoading = true;
    notifyListeners();
    await studentService.getAll();
    Response response = await currentService.getAll();
    if (response.statusCode == 200) {}
    isLoading = false;
    notifyListeners();
  }

  List<TableRow> listTableRow = new List<TableRow>();
  List<String> headers = ["Name", "Gender", "Email", "Action"];

  refreshList() async {
    listTableRow.clear();
    listTableRow.add(TableRow(children: [
      TableCell(child: Center(child: Text(''))),
    ]));
    headers.forEach((element) {
      listTableRow.last.children.add(
        TableCell(child: Center(child: Text(element))),
      );
    });

    for (int i = 0; i < currentModel.children.length; i++) {
      listTableRow.add(
        TableRow(children: [
          TableCell(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text((i + 1).toString()),
                  ))),
          TableCell(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(currentModel.children.elementAt(i).name)),
          )),
          TableCell(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(currentModel.children.elementAt(i).gender)),
          )),
          TableCell(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(currentModel.children.elementAt(i).userAccount.email)),
          )),
          TableCell(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await onDelete(currentModel.children.elementAt(i));
                  },
                ),
              ],
            ),
          )),
        ]),
      );
    }
    notifyListeners();
  }

  onCancel() async {
    currentStudentModel = null;

    isAddElementVisible = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 300));
  }

  String dropdownErrorStudentModel = null;
  onValid() async {
    bool isEverythinISOkey = true;
    if (currentStudentModel == null) {
      dropdownErrorStudentModel = "Select Student";
      isEverythinISOkey = false;
    }
    notifyListeners();
    if (!isEverythinISOkey) return;
    if (currentModel.children == null) currentModel.children = new List<StudentModel>();
    currentModel.children.removeWhere((element) => element.id == currentStudentModel.id);
    currentModel.children.add(currentStudentModel);

    await currentService.update(currentModel);
    refreshList();
    onCancel();
  }

  onDelete(child) async {
    final _bottomSheetService = locator<BottomSheetService>();
    var response = await _bottomSheetService.showBottomSheet(
        title: "Are you sure you want delete this record ?",
        description: "click on Yes to confirm suppresion of the record",
        confirmButtonTitle: "YES",
        cancelButtonTitle: "NO");
    if (response == null) return;
    if (response.confirmed) {
      isAddElementVisible = false;
      notifyListeners();
      print(currentModel.children.remove(child));
      await currentService.update(currentModel);
      // await currentService.delete(ClassRoomModel(id: id));
      // await onRefresh();
      await refreshList();
    }
  }

  onCreateNew() async {
    currentStudentModel = null;

    isAddElementVisible = true;
    notifyListeners();
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

  get fitlerListOfStudents {
    List<StudentModel> newList = new List<StudentModel>();
    studentService.list.forEach((element1) {
      bool alreadyexist = false;
      currentModel.children.forEach((element2) {
        if (element1.id == element2.id) {
          alreadyexist = true;
        }
      });
      if (!alreadyexist) newList.add(element1);
    });
    return newList;
  }
}
