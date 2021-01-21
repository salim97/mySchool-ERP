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
