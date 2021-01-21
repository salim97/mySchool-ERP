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
  OneTimeTable currentOneTimeTable = new OneTimeTable();

  final WorkingHoursService workingHoursService = locator<WorkingHoursService>();
  final TeacherSubjectService teacherSubjectService = locator<TeacherSubjectService>();
  final ClassRoomService classRoomService = locator<ClassRoomService>();
  // TeacherSubjectModel teacherSubjectModel_subject = new TeacherSubjectModel();
  // TeacherSubjectModel teacherSubjectModel_teacher = new TeacherSubjectModel();
  // ClassRoomModel classRoomModel = new ClassRoomModel();

  //tableview needs this variables
  bool isAddElementVisible = false;
  List<TableRow> listTableRow = new List<TableRow>();
  List<String> days = ['saturday', 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday'];
  timeTableRefresh() async {
    listTableRow.clear();
    listTableRow.add(TableRow(children: [
      TableCell(child: Center(child: Text(''))),
    ]));
    days.forEach((element) {
      listTableRow.last.children.add(
        TableCell(child: Center(child: Text(element))),
      );
    });

    for (int i = 0; i < workingHoursService.list.length; i++) {
      if (workingHoursService.list.elementAt(i).type == "Pause") continue;
      listTableRow.add(
        TableRow(children: [
          TableCell(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(workingHoursService.list.elementAt(i).startTime + " - " + workingHoursService.list.elementAt(i).endTime)),
          )),
        ]),
      );
      for (int j = 0; j < 7; j++) {
        bool skip = false;
        if (currentModel.children != null)
          currentModel.children.forEach((element) {
            if (element.workingHoursModel.id == workingHoursService.list.elementAt(i).id && element.day == days.elementAt(j)) {
              skip = true;
              listTableRow.last.children.add(
                TableCell(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Container(
                    height: 70,
                    width: 100,
                    child: Column(
                      children: [
                        Text(element.classRoomModel.room_number),
                        Text(element.teacherSubjectModel.subjectid.name),
                        Text(element.teacherSubjectModel.teacherid.name),
                      ],
                    ),
                  )),
                )),
              );
            }
          });
        if (skip) continue;
        if (workingHoursService.list.elementAt(i).type == "Pause") continue;
        listTableRow.last.children.add(
          TableCell(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: FloatingActionButton(
              mini: true,
              child: Icon(Icons.add),
              onPressed: () {
                onCreateNew();
                currentOneTimeTable.day = days.elementAt(j);
                currentOneTimeTable.workingHoursModel = workingHoursService.list.elementAt(i);
              },
            )),
          )),
        );
      }
    }
    notifyListeners();
  }

  onRefresh() async {
    await currentService.getAll();
    await workingHoursService.getAll();

    await teacherSubjectService.getAll();
    await classRoomService.getAll();
    notifyListeners();
  }

  onCreateNew() async {
    currentOneTimeTable.teacherSubjectModel.id = null;
    currentOneTimeTable.classRoomModel.id = null;

    isAddElementVisible = true;
    notifyListeners();
  }

  onValid() async {
    print("ZEBI");
    if (currentModel.children == null) currentModel.children = new List<OneTimeTable>();
    currentModel.children.add(currentOneTimeTable);
    print(currentModel.toJson());
    await currentService.update(currentModel);
    timeTableRefresh();
    await onCancel();
    // await onRefresh();
  }

  onCancel() async {
    currentModel.id = null;
    currentOneTimeTable.teacherSubjectModel.id = null;
    currentOneTimeTable.classRoomModel.id = null;
    currentOneTimeTable.workingHoursModel.id = null;

    isAddElementVisible = false;
    notifyListeners();
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
