import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../common.dart';
import '../rest_api.dart';

abstract class StudentService extends RestAPI {
  List<StudentModel> listStudentModel;
  Future<Response> getAll();
  Future<Response> add(StudentModel studentModel);
  Future<Response> update(StudentModel studentModel);
  Future<List<StudentModel>> search(String query);
  Future<Response> delete(StudentModel id);
  String secret;
}

class StudentServiceImpl extends RestAPI implements StudentService {
  @override
  List<StudentModel> listStudentModel = new List<StudentModel>();


  @override
  Future<Response> add(StudentModel studentModel) async {
    Response response = await myDioPOST(
      url: serverIP + "/api/v1/students",
      data: studentModel.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }

  @override
  Future<Response> getAll() async {
    Response response = await myDioGET(
      url: serverIP + "/api/v1/students",
    );
    // logger.d(response.data);
    // logger.d(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> list = response.data["data"]["data"];
      listStudentModel.clear();
      list.forEach((element) {
        listStudentModel.add(StudentModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> delete(StudentModel studentModel) async {
    Response response = await myDioDELETE(
      url: serverIP + "/api/v1/students/" + studentModel.id,
    );
    if (response.statusCode == 204) {
      listStudentModel.removeWhere((element) => element.id == studentModel.id);
    }
    return response;
  }

  @override
  Future<List<StudentModel>> search(String query) {
    List<StudentModel> selected = new List<StudentModel>();
    listStudentModel.forEach((element) {
      if (element.userAccount.name.contains(query)) selected.add(element);
      // if (element.userAccount.email.contains(query)) selected.add(element);
      if (element.phone.contains(query)) selected.add(element);
      // if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<StudentModel>>.value(selected);
  }

  @override
  Future<Response> update(StudentModel studentModel) async {
    Response response = await myDioPATCH(
      url: serverIP + "/api/v1/students/" + studentModel.id,
      data: studentModel.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }

  @override
  String secret;
}

// class FakeStudentService extends RestAPI implements StudentService {
//   List<StudentModel> listStudentModel = new List<StudentModel>();
//   FakeStudentService() {
//     for (int i = 0; i < 15; i++) {
//       int randomInt = Random().nextInt(99999999);
//       listStudentModel.add(new StudentModel(
//         id: randomInt.toString(),
//         parent_id: randomInt.toString(),
//         rollNo: randomInt.toString(),
//         first_name: "student ",
//         last_name: i.toString(),
//         phone: "06" + randomInt.toString(),
//       ));
//     }
//   }
//   @override
//   Future<Response> add(StudentModel studentModel) {
//     listStudentModel.add(studentModel);
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<Response> getAll() {
//     // liststudentModel.clear();
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<List<StudentModel>> search(String query) {
//     List<StudentModel> selected = new List<StudentModel>();
//     listStudentModel.forEach((element) {
//       if (element.phone.contains(query)) selected.add(element);
//       // if (element.name.contains(query)) selected.add(element);
//     });
//     return Future<List<StudentModel>>.value(selected);
//   }

//   @override
//   Future<Response> delete(StudentModel id) {
//     print(listStudentModel.length);
//     // for (int i = 0; i < liststudentModel.length; i++) {
//     //   if (liststudentModel.elementAt(i).id == id) {
//     //     liststudentModel.removeAt(i);
//     //   }
//     // }
//     listStudentModel.removeWhere((element) {
//       print(element.id.toString() + " == " + id.toString());
//       return element.id == id;
//     });
//     print(listStudentModel.length);
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<Response> update(StudentModel studentModel) {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
// }
