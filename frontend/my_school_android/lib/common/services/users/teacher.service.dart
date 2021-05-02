import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import '../../common.dart';

abstract class TeacherService {
  List<TeacherModel> list;
  Future<Response> getAll();
  Future<Response> add(TeacherModel teacherModel);
  Future<Response> update(TeacherModel teacherModel);
  Future<List<TeacherModel>> search(String query);
  Future<Response> delete(TeacherModel id);
}

class TeacherServiceImpl extends RestAPI implements TeacherService {
  @override
  List<TeacherModel> list = new List<TeacherModel>();

  @override
  Future<Response> add(TeacherModel teacherModel) async {
    Response response = await myDioPOST(
      url: serverIP + "/api/v1/teachers",
      data: teacherModel.toJson(),
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
      List<dynamic> _temp = response.data["data"]["data"];
      list.clear();
      _temp.forEach((element) {
        list.add(TeacherModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> delete(TeacherModel teacherModel) async {
    Response response = await myDioDELETE(
      url: serverIP + "/api/v1/teachers/" + teacherModel.id,
    );
    if (response.statusCode == 204) {
      list.removeWhere((element) => element.id == teacherModel.id);
    }
    return response;
  }

  @override
  Future<List<TeacherModel>> search(String query) {
    List<TeacherModel> selected = new List<TeacherModel>();
    list.forEach((element) {
      if (element.name.contains(query)) selected.add(element);
      // if (element.userAccount.email.contains(query)) selected.add(element);
      if (element.phone.contains(query)) selected.add(element);
      // if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<TeacherModel>>.value(selected);
  }

  @override
  Future<Response> update(TeacherModel teacherModel) async {
    Response response = await myDioPATCH(
      url: serverIP + "/api/v1/teachers/" + teacherModel.id,
      data: teacherModel.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }
}

class TeacherServiceFake extends RestAPI implements TeacherService {
  @override
  List<TeacherModel> list = new List<TeacherModel>();
  TeacherServiceFake() {
    list.add(TeacherModel(id: "01", employee_code: "01", name: "Salim", subjects_handling: "Math", phone: "05 *** ***"));
    list.add(TeacherModel(id: "02", employee_code: "02", name: "Amine", subjects_handling: "Math", phone: "05 *** ***"));
    list.add(TeacherModel(id: "03", employee_code: "03", name: "Chakib", subjects_handling: "Math", phone: "05 *** ***"));
    list.add(TeacherModel(id: "04", employee_code: "04", name: "Kader", subjects_handling: "Math", phone: "05 *** ***"));
  }

  @override
  Future<Response> add(TeacherModel teacherModel) async {
    list.add(teacherModel);
    return Response(statusCode: 201);
  }

  @override
  Future<Response> getAll() async {
    return Response(statusCode: 200);
  }

  @override
  Future<Response> delete(TeacherModel teacherModel) async {
    list.removeWhere((element) => element.id == teacherModel.id);

    return Response(statusCode: 201);
  }

  @override
  Future<List<TeacherModel>> search(String query) {
    List<TeacherModel> selected = new List<TeacherModel>();
    list.forEach((element) {
      if (element.name.contains(query)) selected.add(element);
      // if (element.userAccount.email.contains(query)) selected.add(element);
      if (element.phone.contains(query)) selected.add(element);
      // if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<TeacherModel>>.value(selected);
  }

  @override
  Future<Response> update(TeacherModel teacherModel) async {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).id == teacherModel.id) list[i] = teacherModel;
    }
    return Response(statusCode: 201);
  }
}
