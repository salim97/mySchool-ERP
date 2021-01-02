import 'dart:convert';
import 'dart:math';


import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../common.dart';

abstract class TeacherService {
  List<TeacherModel> listStudentModel;
  Future<Response> getAll();
  Future<Response> add(TeacherModel studentModel);
  Future<Response> update(TeacherModel studentModel);
  Future<List<TeacherModel>> search(String query);
  Future<Response> delete(TeacherModel id);
}

class FakeTeacherService implements TeacherService {
  @override
  List<TeacherModel> listStudentModel;

  @override
  Future<Response> add(TeacherModel studentModel) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Response> delete(TeacherModel id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Response> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<List<TeacherModel>> search(String query) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<Response> update(TeacherModel studentModel) {
    // TODO: implement update
    throw UnimplementedError();
  }
  // List<TeacherModel> listTeacherModel = new List<TeacherModel>();
  // FakeTeacherService() {
  //   for (int i = 0; i < 15; i++) {
  //     int randomInt = Random().nextInt(99999999);
  //     listTeacherModel.add(new TeacherModel(
  //       id: randomInt,
  //       employee_code: randomInt.toString(),
  //       full_name: "teacher " + i.toString(),
  //       phone: "06" + randomInt.toString(),
  //     ));
  //   }
  //   // listTeacherModel.add(new TeacherModel(id: 1, first_name: "azer", last_name: "rtyu", phone: "789123"));
  //   // listTeacherModel.add(new TeacherModel(id: 2, first_name: "qsdf", last_name: "fghj", phone: "654789"));
  //   // listTeacherModel.add(new TeacherModel(id: 3, first_name: "wxcv", last_name: "vbn", phone: "123456"));
  // }
  // @override
  // Future<bool> add(TeacherModel teacherModel) {
  //   listTeacherModel.add(teacherModel);
  //   return Future<bool>.value(true);
  // }

  // @override
  // Future<List<TeacherModel>> getAll() {
  //   // listTeacherModel.clear();
  //   return Future<List<TeacherModel>>.value(listTeacherModel);
  // }

  // @override
  // Future<List<TeacherModel>> search(String query) {
  //   List<TeacherModel> selected = new List<TeacherModel>();
  //   listTeacherModel.forEach((element) {
  //     if (element.phone.contains(query)) selected.add(element);
  //     if (element.full_name.contains(query)) selected.add(element);
  //   });
  //   return Future<List<TeacherModel>>.value(selected);
  // }

  // @override
  // Future<List<TeacherModel>> delete(int id) {
  //   print(listTeacherModel.length);
  //   // for (int i = 0; i < listTeacherModel.length; i++) {
  //   //   if (listTeacherModel.elementAt(i).id == id) {
  //   //     listTeacherModel.removeAt(i);
  //   //   }
  //   // }
  //   listTeacherModel.removeWhere((element) {
  //     print(element.id.toString() + " == " + id.toString());
  //     return element.id == id;
  //   });
  //   print(listTeacherModel.length);
  //   return Future<List<TeacherModel>>.value(listTeacherModel);
  // }
}

class TeacherServiceImpl extends RestAPI implements TeacherService {
  @override
  List<TeacherModel> listStudentModel = new List<TeacherModel>();

  @override
  Future<Response> add(TeacherModel studentModel) async {
    Response response = await myDioPOST(
      url: serverIP + "/api/v1/teachers",
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
      url: serverIP + "/api/v1/teachers",
    );
    if (response.statusCode == 200) {
      List<dynamic> list = response.data["data"]["data"];
      listStudentModel.clear();
      list.forEach((element) {
        listStudentModel.add(TeacherModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> delete(TeacherModel teacherModel) async{
    Response response = await myDioDELETE(
      url: serverIP + "/api/v1/teachers/" + teacherModel.id,
    );
    if (response.statusCode == 204) {
      listStudentModel.removeWhere((element) => element.id == teacherModel.id);
    }
    return response;
  }

  @override
  Future<List<TeacherModel>> search(String query) {
    List<TeacherModel> selected = new List<TeacherModel>();
    listStudentModel.forEach((element) {
      if (element.userAccount.name.contains(query)) selected.add(element);
      // if (element.userAccount.email.contains(query)) selected.add(element);
      if (element.phone.contains(query)) selected.add(element);
      // if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<TeacherModel>>.value(selected);
  }

  @override
  Future<Response> update(TeacherModel studentModel) async {
    Response response = await myDioPATCH(
      url: serverIP + "/api/v1/teachers/" + studentModel.id,
      data: studentModel.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }
}
