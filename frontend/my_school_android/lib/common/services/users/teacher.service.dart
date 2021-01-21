import 'package:dio/dio.dart';
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
      List<dynamic> temp = response.data["data"]["data"];
      list.clear();
      temp.forEach((element) {
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
