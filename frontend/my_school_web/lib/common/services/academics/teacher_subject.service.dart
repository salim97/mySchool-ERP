import 'package:dio/dio.dart';

import '../../common.dart';

abstract class TeacherSubjectService extends RestAPI {
  List<TeacherSubjectModel> list;
  Future<Response> getAll();
  Future<Response> add(TeacherSubjectModel model);
  Future<Response> update(TeacherSubjectModel model);
  Future<Response> delete(TeacherSubjectModel model);
  String endPointURL;
}

class TeacherSubjectServiceImpl extends RestAPI implements TeacherSubjectService {
  @override
  List<TeacherSubjectModel> list;
  String endPointURL;
  TeacherSubjectServiceImpl() {
    endPointURL = serverIP + "/api/v1/academics/teacherSubject_service";
    list = new List<TeacherSubjectModel>();
  }
  @override
  Future<Response> add(TeacherSubjectModel model) async {
    Response response = await myDioPOST(
      url: endPointURL,
      data: model.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }

  @override
  Future<Response> delete(TeacherSubjectModel model) async {
    Response response = await myDioDELETE(
      url: endPointURL + "/" + model.id,
    );
    if (response.statusCode == 204) {
      list.removeWhere((element) => element.id == model.id);
    }
    return response;
  }

  @override
  Future<Response> getAll() async {
    Response response = await myDioGET(
      url: endPointURL,
    );
    // logger.d(response.data);
    // logger.d(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> temp = response.data["data"]["data"];
      list.clear();
      temp.forEach((element) {
        list.add(TeacherSubjectModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> update(TeacherSubjectModel model) async {
    Response response = await myDioPATCH(
      url: endPointURL + "/" + model.id,
      data: model.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }
}
