import 'package:dio/dio.dart';

import '../../common.dart';

abstract class GroupService extends RestAPI {
  List<GroupModel> list;
  Future<Response> getAll();
  Future<Response> add(GroupModel model);
  Future<Response> update(GroupModel model);
  Future<Response> delete(GroupModel model);
  String endPointURL;
}

class GroupServiceImpl extends RestAPI implements GroupService {
  @override
  List<GroupModel> list;
  String endPointURL;
  GroupServiceImpl() {
    endPointURL = serverIP + "/api/v1/academics/group_service";
    list = new List<GroupModel>();
  }
  @override
  Future<Response> add(GroupModel model) async {
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
  Future<Response> delete(GroupModel model) async {
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
        list.add(GroupModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> update(GroupModel model) async {
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

class GroupServiceFake extends RestAPI implements GroupService {
  @override
  List<GroupModel> list;
  String endPointURL;
  GroupServiceFake() {
    endPointURL = serverIP + "/api/v1/academics/classRoom_service";
    list = new List<GroupModel>();
    list.clear();
    for (int i = 0; i < 3; i++)
      list.add(GroupModel(id: i.toString(),  name: "Group "+i.toString(), section: SectionModel(name: "Section"+i.toString()), createdAt: "2021-03-20"));
  }
  @override
  Future<Response> add(GroupModel model) async {
    list.add(model);
    return Response(statusCode: 200);
  }

  @override
  Future<Response> delete(GroupModel model) async {
    list.removeWhere((element) => element.id == model.id);

        return Response(statusCode: 200);
  }

  @override
  Future<Response> getAll() async {
  return Response(statusCode: 200);
  }

  @override
  Future<Response> update(GroupModel model) async {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).id == model.id) list[i] = model;
    }
    return Response(statusCode: 200);
  }
}

