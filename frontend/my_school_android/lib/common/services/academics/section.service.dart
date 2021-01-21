import 'package:dio/dio.dart';

import '../../common.dart';

abstract class SectionService extends RestAPI {
  List<SectionModel> list;
  Future<Response> getAll();
  Future<Response> add(SectionModel model);
  Future<Response> update(SectionModel model);
  Future<Response> delete(SectionModel model);
  String endPointURL;
}

class SectionServiceImpl extends RestAPI implements SectionService {
  @override
  List<SectionModel> list;
  String endPointURL;
  SectionServiceImpl() {
    endPointURL = serverIP + "/api/v1/academics/section_service";
    list = new List<SectionModel>();
  }
  @override
  Future<Response> add(SectionModel model) async {
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
  Future<Response> delete(SectionModel model) async {
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
        list.add(SectionModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> update(SectionModel model) async {
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