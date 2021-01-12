import 'package:dio/dio.dart';

import '../../common.dart';

abstract class WorkingHoursService extends RestAPI {
  List<WorkingHoursModel> list;
  Future<Response> getAll();
  Future<Response> add(WorkingHoursModel model);
  Future<Response> update(WorkingHoursModel model);
  Future<Response> delete(WorkingHoursModel model);
  String endPointURL;
}

class WorkingHoursServiceImpl extends RestAPI implements WorkingHoursService {
  @override
  List<WorkingHoursModel> list;
  String endPointURL;
  WorkingHoursServiceImpl() {
    endPointURL = serverIP + "/api/v1/academics/workinghours_service";
    list = new List<WorkingHoursModel>();
  }
  @override
  Future<Response> add(WorkingHoursModel model) async {
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
  Future<Response> delete(WorkingHoursModel model) async {
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
        list.add(WorkingHoursModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> update(WorkingHoursModel model) async {
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
