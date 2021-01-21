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
