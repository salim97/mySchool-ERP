import 'dart:convert';
import 'dart:math';

import 'package:common/models/student_model.dart';
import 'package:common/models/user_model.dart';
import 'package:common/rest_api.dart';
import 'package:crypto/crypto.dart';

abstract class StudentService {
  Future<List<StudentModel>> getAll();
  Future<bool> add(StudentModel teacherModel);
  Future<List<StudentModel>> search(String query);
  Future<List<StudentModel>> delete(int id);
}

class FakeStudentService implements StudentService {
  List<StudentModel> listStudentModel = new List<StudentModel>();
  FakeStudentService() {
    for (int i = 0; i < 15; i++) {
      int randomInt = Random().nextInt(99999999);
      listStudentModel.add(new StudentModel(
        id: randomInt,
        parent_id: randomInt,
        rollNo: randomInt.toString(),
        first_name: "student ",
        last_name: i.toString(),
        phone: "06" + randomInt.toString(),
      ));
    }
  }
  @override
  Future<bool> add(StudentModel teacherModel) {
    listStudentModel.add(teacherModel);
    return Future<bool>.value(true);
  }

  @override
  Future<List<StudentModel>> getAll() {
    // listTeacherModel.clear();
    return Future<List<StudentModel>>.value(listStudentModel);
  }

  @override
  Future<List<StudentModel>> search(String query) {
    List<StudentModel> selected = new List<StudentModel>();
    listStudentModel.forEach((element) {
      if (element.phone.contains(query)) selected.add(element);
      // if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<StudentModel>>.value(selected);
  }

  @override
  Future<List<StudentModel>> delete(int id) {
    print(listStudentModel.length);
    // for (int i = 0; i < listTeacherModel.length; i++) {
    //   if (listTeacherModel.elementAt(i).id == id) {
    //     listTeacherModel.removeAt(i);
    //   }
    // }
    listStudentModel.removeWhere((element) {
      print(element.id.toString() + " == " + id.toString());
      return element.id == id;
    });
    print(listStudentModel.length);
    return Future<List<StudentModel>>.value(listStudentModel);
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
