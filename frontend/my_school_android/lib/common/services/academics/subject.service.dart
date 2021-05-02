import 'package:dio/dio.dart';

import '../../common.dart';

abstract class SubjectService extends RestAPI {
  List<SubjectModel> list;
  Future<Response> getAll();
  Future<Response> add(SubjectModel model);
  Future<Response> update(SubjectModel model);
  Future<Response> delete(SubjectModel model);
  String endPointURL;
}

class SubjectServiceImpl extends RestAPI implements SubjectService {
  @override
  List<SubjectModel> list;
  String endPointURL;
  SubjectServiceImpl() {
    endPointURL = serverIP + "/api/v1/academics/subject_service";
    list = new List<SubjectModel>();
  }
  @override
  Future<Response> add(SubjectModel model) async {
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
  Future<Response> delete(SubjectModel model) async {
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
        list.add(SubjectModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> update(SubjectModel model) async {
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

class SubjectServiceFake extends RestAPI implements SubjectService {
  @override
  List<SubjectModel> list;
  String endPointURL;
  SubjectServiceFake() {
    endPointURL = serverIP + "/api/v1/academics/subject_service";
    list = new List<SubjectModel>();
    list.add(SubjectModel(name: "Math", type: "TD"));
    list.add(SubjectModel(name: "Physique", type: "TD"));
    list.add(SubjectModel(name: "Francais", type: "TD"));
    list.add(SubjectModel(name: "Anglais", type: "TD"));
  }

  @override
  Future<Response> add(SubjectModel model) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Response> delete(SubjectModel model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Response> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Response> update(SubjectModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
