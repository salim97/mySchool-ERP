import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked_services/stacked_services.dart';

class TimeTableViewModel extends BaseViewModel {
  // services
  final TimeTableService currentService = locator<TimeTableService>();
  final AuthService authService = locator<AuthService>();
  TimeTableModel currentModel = new TimeTableModel();

  final TeacherSubjectService teacherSubjectService = locator<TeacherSubjectService>();
  final ClassRoomService classRoomService = locator<ClassRoomService>();
  TeacherSubjectModel teacherSubjectModel_subject = new TeacherSubjectModel();
  TeacherSubjectModel teacherSubjectModel_teacher = new TeacherSubjectModel();
  ClassRoomModel classRoomModel = new ClassRoomModel();

  //tableview needs this variables
  bool isAddElementVisible = false;
  List<TableRow> listTableRow = new List<TableRow>();

  onRefresh() async {
    listTableRow.add(TableRow(children: [
      TableCell(child: Center(child: Text(''))),
      TableCell(child: Center(child: Text('samedi'))),
      TableCell(child: Center(child: Text('dimanche'))),
      TableCell(child: Center(child: Text('lundi'))),
      TableCell(child: Center(child: Text('mardi'))),
      TableCell(child: Center(child: Text('mercredi'))),
      TableCell(child: Center(child: Text('jeudi'))),
      TableCell(child: Center(child: Text('vendredi'))),
    ]));
    for (int i = 1; i < 5; i++) {
      listTableRow.add(TableRow(children: [
        TableCell(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(i.toString())),
        )),
      ]));
      for (int i = 0; i < 7; i++)
        listTableRow.last.children.add(
          TableCell(
            
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: FloatingActionButton(
                      mini: true,
            child: Icon(Icons.add),
            onPressed: () {
                print("zebi");
            },
          )),
              )),
        );
    }
    notifyListeners();
    await teacherSubjectService.getAll();
    await classRoomService.getAll();
    Response response = await currentService.getAll();
    if (response.statusCode == 200) {
      currentService.list.forEach((element) {});
    }
  }

  onCreateNew() async {
    currentModel.id = null;
    teacherSubjectModel_subject.id = null;
    teacherSubjectModel_teacher.id = null;
    classRoomModel.id = null;

    isAddElementVisible = true;
    notifyListeners();
  }

  onValid() async {
    // currentModel.room_number = roomNameController.text;
    // currentModel.capacity = int.parse(capacityController.text);
    // if (currentModel.id == null) {
    //   currentService.add(currentModel);
    // } else {
    //   currentService.update(currentModel);
    // }
    // await onRefresh();
    // await onCancel();
  }

  onCancel() async {
    // currentModel.id = null;
    // roomNameController.text = "";
    // capacityController.text = "";
    // isAddElementVisible = false;
    // notifyListeners();
  }

  onEdit(id) async {
    // currentModel = currentService.list.firstWhere((element) => element.id == id);
    // roomNameController.text = currentModel.room_number;
    // capacityController.text = currentModel.capacity.toString();
    // isAddElementVisible = true;
    // notifyListeners();
    // // await locator<NavigationService>().navigateTo(Routes.addStudentView, arguments: tm);
    // // await onRefresh();
  }

  onDelete(id) async {
    // final _bottomSheetService = locator<BottomSheetService>();
    // var response = await _bottomSheetService.showBottomSheet(
    //     title: "Are you sure you want delete this record ?",
    //     description: "click on Yes to confirm suppresion of the record",
    //     confirmButtonTitle: "YES",
    //     cancelButtonTitle: "NO");
    // if (response == null) return;
    // if (response.confirmed) {
    //   await currentService.delete(ClassRoomModel(id: id));
    //   await onRefresh();
    // }
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
