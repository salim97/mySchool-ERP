import 'package:dio/dio.dart';

import '../../common.dart';

abstract class ClassRoomService extends RestAPI {
  List<ClassRoomModel> list;
  Future<Response> getAll();
  Future<Response> add(ClassRoomModel model);
  Future<Response> update(ClassRoomModel model);
  Future<Response> delete(ClassRoomModel model);
  String endPointURL;
}

class ClassRoomServiceImpl extends RestAPI implements ClassRoomService {
  @override
  List<ClassRoomModel> list;
  String endPointURL;
  ClassRoomServiceImpl() {
    endPointURL = serverIP + "/api/v1/academics/classRoom_service";
    list = new List<ClassRoomModel>();
  }
  @override
  Future<Response> add(ClassRoomModel model) async {
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
  Future<Response> delete(ClassRoomModel model) async {
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
    if (response.statusCode == 200) {
      List<dynamic> temp = response.data["data"]["data"];
      list.clear();
      temp.forEach((element) {
        list.add(ClassRoomModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> update(ClassRoomModel model) async {
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
