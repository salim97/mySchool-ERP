import 'package:dio/dio.dart';

import '../../common.dart';

abstract class NotificationService extends RestAPI {
  List<NotificationModel> list;
  Future<Response> getAll();
  Future<Response> add(NotificationModel model);
  Future<Response> delete(NotificationModel model);
  String endPointURL;
}

class NotificationServiceImpl extends RestAPI implements NotificationService {
  @override
  List<NotificationModel> list;
  ClassRoomModel model;
  String endPointURL;
  NotificationServiceImpl() {
    endPointURL = serverIP + "/api/v1/notify";
    list = new List<NotificationModel>();
  }
  @override
  Future<Response> add(NotificationModel model) async {
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
  Future<Response> delete(NotificationModel model) async {
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
        list.add(NotificationModel.fromJson(element));
      });
    }
    return response;
  }
}

class NotificationServiceFake extends RestAPI implements NotificationService {
  @override
  List<NotificationModel> list;
  String endPointURL;
  NotificationServiceFake() {
    endPointURL = serverIP + "/api/v1/academics/classRoom_service";
    list = new List<NotificationModel>();
    list.add(NotificationModel(
        title: "Title 01",
        message:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud "));
    list.add(NotificationModel(
        title: "Title 02",
        message:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud "));
    list.add(NotificationModel(
        title: "Title 03",
        message:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud "));
  }

  @override
  Future<Response> add(NotificationModel model) async {
    list.add(model);
    return null;
  }

  @override
  Future<Response> delete(NotificationModel model) async {
    list.removeWhere((element) => element.id == model.id);

    return null;
  }

  @override
  Future<Response> getAll() async {
    return null;
  }

  @override
  Future<Response> update(NotificationModel model) async {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).id == model.id) list[i] = model;
    }
    return null;
  }
}
