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
  ClassRoomModel model;
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

class ClassRoomServiceFake extends RestAPI implements ClassRoomService {
  @override
  List<ClassRoomModel> list;
  ClassRoomModel model;
  String endPointURL;
  ClassRoomServiceFake() {
    endPointURL = serverIP + "/api/v1/academics/classRoom_service";
    list = new List<ClassRoomModel>();
    list.clear();
    for (int i = 0; i < 5; i++)
      list.add(ClassRoomModel(id: i.toString(), capacity: 20, room_number: "A"+i.toString(), createdAt: "2021-03-20"));
  }
  @override
  Future<Response> add(ClassRoomModel model) async {
    list.add(model);
      return Response(statusCode: 200);
  }

  @override
  Future<Response> delete(ClassRoomModel model) async {
    list.removeWhere((element) => element.id == model.id);

        return Response(statusCode: 200);
  }

  @override
  Future<Response> getAll() async {
  return Response(statusCode: 200);
  }

  @override
  Future<Response> update(ClassRoomModel model) async {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).id == model.id) list[i] = model;
    }
    return Response(statusCode: 200);
  }
}
