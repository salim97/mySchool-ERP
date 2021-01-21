import 'package:dio/dio.dart';

import '../../common.dart';

abstract class TimeTableService extends RestAPI {
  List<TimeTableModel> list;
  Future<Response> getAll();
  Future<Response> add(TimeTableModel model);
  Future<Response> update(TimeTableModel model);
  Future<Response> delete(TimeTableModel model);
  String endPointURL;
}

class TimeTableServiceImpl extends RestAPI implements TimeTableService {
  @override
  List<TimeTableModel> list;
  String endPointURL;
  TimeTableServiceImpl() {
    endPointURL = serverIP + "/api/v1/academics/timeTable_service";
    list = new List<TimeTableModel>();
  }
  @override
  Future<Response> add(TimeTableModel model) async {
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
  Future<Response> delete(TimeTableModel model) async {
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
        list.add(TimeTableModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> update(TimeTableModel model) async {
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
