import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked_services/stacked_services.dart';

class TimeTableViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                    // height: 70,
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(element.classRoomModel.room_number),
                        Text(element.teacherSubjectModel.subjectid.name),
                        Text(element.teacherSubjectModel.teacherid.name),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () async {
                                await onEdit(element);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await onDelete(element);
                              },
                            )
                          ],
                        )
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
                onCreateNew(
                  day: days.elementAt(j),
                  workingHoursModel: workingHoursService.list.elementAt(i),
                );
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

  onCreateNew({day, workingHoursModel}) async {
    await onCancel();
    currentOneTimeTable.day = day;
    currentOneTimeTable.workingHoursModel = WorkingHoursModel.fromJson(workingHoursModel.toJson());
    // currentModel.id = null;

    isAddElementVisible = true;
    notifyListeners();
  }

  onCancel() async {
        currentOneTimeTable = new OneTimeTable();
    currentOneTimeTable.classRoomModel = null;
    currentOneTimeTable.teacherSubjectModel = null;
    // currentOneTimeTable.day = null;
    // currentOneTimeTable.workingHoursModel = null;


    dropdownErrorTeacherSubjectModel = null;
    dropdownErrorClassRoomModel = null;

    isAddElementVisible = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 300));
  }

  String dropdownErrorTeacherSubjectModel = null;
  String dropdownErrorClassRoomModel = null;
  onValid() async {
    bool isEverythinISOkey = true;
    if (currentOneTimeTable.teacherSubjectModel == null) {
      dropdownErrorTeacherSubjectModel = "select teacher subject";
      isEverythinISOkey = false;
    }
    if (currentOneTimeTable.classRoomModel == null) {
      dropdownErrorClassRoomModel = "select class room";
      isEverythinISOkey = false;
    }
    notifyListeners();
    if (!isEverythinISOkey) return;
    if (currentModel.children == null) currentModel.children = new List<OneTimeTable>();

    currentModel.children.removeWhere(
        (element) => element.day == currentOneTimeTable.day && element.workingHoursModel.id == currentOneTimeTable.workingHoursModel.id);
    currentModel.children.add(currentOneTimeTable);

    await currentService.update(currentModel);
    await onCancel();
    await timeTableRefresh();
    // await onRefresh();
  }

  onEdit(OneTimeTable child) async {
    await onCancel();
    currentOneTimeTable.classRoomModel = ClassRoomModel.fromJson(child.classRoomModel.toJson());
    currentOneTimeTable.teacherSubjectModel = TeacherSubjectModel.fromJson(child.teacherSubjectModel.toJson());
    currentOneTimeTable.workingHoursModel = WorkingHoursModel.fromJson(child.workingHoursModel.toJson());
    currentOneTimeTable.day = child.day;

    isAddElementVisible = true;
    notifyListeners();
    // await locator<NavigationService>().navigateTo(Routes.addStudentView, arguments: tm);
    // await onRefresh();
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
      await timeTableRefresh();
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
