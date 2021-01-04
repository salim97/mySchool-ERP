import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import '../common.dart';

abstract class WorkingHoursService {
  Future<List<WorkingHoursModel>> getAll();
  Future<bool> add(WorkingHoursModel teacherModel);
  Future<List<WorkingHoursModel>> delete(int id);
}

class FakeWorkingHoursService implements WorkingHoursService {
  List<WorkingHoursModel> listWorkingHoursModel = new List<WorkingHoursModel>();
  FakeWorkingHoursService() {
    listWorkingHoursModel.add(new WorkingHoursModel(
      id: 0,
      class_hour_name: "seance 1",
      from: "08:00",
      to: "09:30",
      type: "teaching",
    ));
    listWorkingHoursModel.add(new WorkingHoursModel(
      id: 1,
      class_hour_name: "seance 2",
      from: "09:30",
      to: "11:00",
      type: "teaching",
    ));
    listWorkingHoursModel.add(new WorkingHoursModel(
      id: 2,
      class_hour_name: "seance 3",
      from: "11:00",
      to: "12:30",
      type: "teaching",
    ));
    listWorkingHoursModel.add(new WorkingHoursModel(
      id: 3,
      class_hour_name: "seance 4",
      from: "12:30",
      to: "14:00",
      type: "teaching",
    ));
    listWorkingHoursModel.add(new WorkingHoursModel(
      id: 4,
      class_hour_name: "seance 5",
      from: "14:00",
      to: "15:30",
      type: "teaching",
    ));
    listWorkingHoursModel.add(new WorkingHoursModel(
      id: 5,
      class_hour_name: "seance 6",
      from: "15:30",
      to: "17:00",
      type: "teaching",
    ));
  }
  @override
  Future<bool> add(WorkingHoursModel teacherModel) {
    listWorkingHoursModel.add(teacherModel);
    return Future<bool>.value(true);
  }

  @override
  Future<List<WorkingHoursModel>> getAll() {
    // listTeacherModel.clear();
    return Future<List<WorkingHoursModel>>.value(listWorkingHoursModel);
  }

  @override
  Future<List<WorkingHoursModel>> delete(int id) {
    print(listWorkingHoursModel.length);
    // for (int i = 0; i < listTeacherModel.length; i++) {
    //   if (listTeacherModel.elementAt(i).id == id) {
    //     listTeacherModel.removeAt(i);
    //   }
    // }
    listWorkingHoursModel.removeWhere((element) {
      print(element.id.toString() + " == " + id.toString());
      return element.id == id;
    });
    print(listWorkingHoursModel.length);
    return Future<List<WorkingHoursModel>>.value(listWorkingHoursModel);
  }
}

// class AuthServiceImpl  extends RestAPI implements AuthService {
//   @override
//   Future login({String email, String password}) async => throw UnimplementedError();

//   @override
//   Future<bool> signout() {
//     // TODO: implement signout
//     throw UnimplementedError();
//   }
// }
