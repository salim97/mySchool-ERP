import 'dart:convert';
import 'dart:math';

import 'package:common/models/teacher_model.dart';
import 'package:common/models/user_model.dart';
import 'package:common/rest_api.dart';
import 'package:crypto/crypto.dart';

abstract class TeacherService {
  Future<List<TeacherModel>> getAll();
  Future<bool> add(TeacherModel teacherModel);
  Future<List<TeacherModel>> search(String query);
  Future<List<TeacherModel>> delete(TeacherModel teacherModel);
}

class FakeTeacherService implements TeacherService {
  List<TeacherModel> listTeacherModel = new List<TeacherModel>();
  FakeTeacherService() {
    for (int i = 0; i < 15; i++) {
      int randomInt = Random().nextInt(99999999);
      listTeacherModel.add(new TeacherModel(
        id: randomInt,
        employee_code: randomInt.toString(),
        first_name: "teacher ",
        last_name: i.toString(),
        phone: "06" + randomInt.toString(),
      ));
    }
    // listTeacherModel.add(new TeacherModel(id: 1, first_name: "azer", last_name: "rtyu", phone: "789123"));
    // listTeacherModel.add(new TeacherModel(id: 2, first_name: "qsdf", last_name: "fghj", phone: "654789"));
    // listTeacherModel.add(new TeacherModel(id: 3, first_name: "wxcv", last_name: "vbn", phone: "123456"));
  }
  @override
  Future<bool> add(TeacherModel teacherModel) {
    listTeacherModel.add(teacherModel);
    return Future<bool>.value(true);
  }

  @override
  Future<List<TeacherModel>> getAll() {
    // listTeacherModel.clear();
    return Future<List<TeacherModel>>.value(listTeacherModel);
  }

  @override
  Future<List<TeacherModel>> search(String query) {
    List<TeacherModel> selected = new List<TeacherModel>();
    listTeacherModel.forEach((element) {
      if (element.phone.contains(query)) selected.add(element);
      if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<TeacherModel>>.value(selected);
  }

  @override
  Future<List<TeacherModel>> delete(TeacherModel teacherModel) {
    listTeacherModel.removeWhere((element) => element.id == teacherModel.id);
    return Future<List<TeacherModel>>.value(listTeacherModel);
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
