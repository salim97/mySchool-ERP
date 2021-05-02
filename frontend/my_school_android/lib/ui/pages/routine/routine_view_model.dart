import 'dart:math';

import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:stacked/stacked.dart';

class RoutineViewModel extends BaseViewModel {
  final AuthService _authService = null; // locator<AuthService>();
  final TimeTableService timeTableService = new TimeTableServiceFake();
  TimeTableModel currentModel = null;
  List<String> days = List<String>();
  init() async {
    if (SHOW_CASE) {
      days.add("dimanche");
      days.add("lundi");
      days.add("mardi");
      days.add("mercredi");
      days.add("jeudi");
      currentModel = new TimeTableModel();
      currentModel.groupid = GroupModel(name: "Group 1", section: SectionModel(name: "Section 1"));
      generate("dimanche").forEach((element) => currentModel.children.add(element));
      generate("lundi").forEach((element) => currentModel.children.add(element));
      generate("mardi").forEach((element) => currentModel.children.add(element));
      generate("mercredi").forEach((element) => currentModel.children.add(element));
      generate("jeudi").forEach((element) => currentModel.children.add(element));
      return;
      timeTableService.list.forEach((element1) {
        element1.groupid.children.forEach((element2) {
          if (currentModel == null) {
            currentModel = element1;
          }
        });
      });

      days.clear();

      currentModel.children.forEach((element2) {
        if (!days.contains(element2.day)) days.add(element2.day);
      });

      return;
    }

    Response response = await _authService.me();
    if (response.statusCode != 200) return;

    if (_authService.userModel.role == "student") {
      StudentModel studentModel = StudentModel.fromJson(response.data["data"]["extra"]);

      await timeTableService.getAll();

      timeTableService.list.forEach((element1) {
        element1.groupid.children.forEach((element2) {
          if (currentModel == null) {
            if (element2.id == studentModel.id) currentModel = element1;
          }
        });
      });

      days.clear();

      currentModel.children.forEach((element2) {
        if (!days.contains(element2.day)) days.add(element2.day);
      });

      print("_authService.logger.d(currentModel)");
      print(days);
      _authService.logger.d(currentModel.toJson());
    }
    notifyListeners();
  }

  List<OneTimeTable> generate(String day) {
    return [
      OneTimeTable(
        day: day,
        classRoomModel: ClassRoomModel(room_number: "A01"),
        teacherSubjectModel: TeacherSubjectModel(subjectid: SubjectModel(name: "Math", type: "TD")),
        workingHoursModel: WorkingHoursModel(startTime: "08:00", endTime: "10:00"),
      ),
      OneTimeTable(
        day: day,
        classRoomModel: ClassRoomModel(room_number: "A01"),
        teacherSubjectModel: TeacherSubjectModel(subjectid: SubjectModel(name: "Physique", type: "TD")),
        workingHoursModel: WorkingHoursModel(startTime: "10:00", endTime: "12:00"),
      ),
      OneTimeTable(
        day: day,
        classRoomModel: ClassRoomModel(room_number: "A01"),
        teacherSubjectModel: TeacherSubjectModel(subjectid: SubjectModel(name: "Francais", type: "TD")),
        workingHoursModel: WorkingHoursModel(startTime: "13:00", endTime: "15:00"),
      ),
      OneTimeTable(
        day: day,
        classRoomModel: ClassRoomModel(room_number: "A01"),
        teacherSubjectModel: TeacherSubjectModel(subjectid: SubjectModel(name: "Anglais", type: "TD")),
        workingHoursModel: WorkingHoursModel(startTime: "15:00", endTime: "17:00"),
      ),
    ];
  }
}
