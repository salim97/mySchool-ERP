import 'dart:math';

import 'package:dio/dio.dart';

import '../../common.dart';
import '../../rest_api.dart';

abstract class ParentService {
  List<ParentModel> listParentModel;
  ParentModel parentModel;
  Future<Response> getAll();
  Future<Response> add(ParentModel parentModel);
  Future<Response> update(ParentModel parentModel);
  Future<List<ParentModel>> search(String query);
  Future<Response> delete(ParentModel id);
}

class ParentServiceImpl extends RestAPI implements ParentService {
  @override
  List<ParentModel> listParentModel = new List<ParentModel>();

  @override
  Future<Response> add(ParentModel parentModel) async {
    Response response = await myDioPOST(
      url: serverIP + "/api/v1/parents",
      data: parentModel.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }

  @override
  Future<Response> getAll() async {
    Response response = await myDioGET(
      url: serverIP + "/api/v1/parents",
    );
    if (response.statusCode == 200) {
      List<dynamic> list = response.data["data"]["data"];
      listParentModel.clear();
      list.forEach((element) {
        listParentModel.add(ParentModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> delete(ParentModel parentModel) async {
    Response response = await myDioDELETE(
      url: serverIP + "/api/v1/parents/" + parentModel.id,
    );
    if (response.statusCode == 204) {
      listParentModel.removeWhere((element) => element.id == parentModel.id);
    }
    return response;
  }

  @override
  Future<List<ParentModel>> search(String query) {
    List<ParentModel> selected = new List<ParentModel>();
    listParentModel.forEach((element) {
      if (element.name.contains(query)) selected.add(element);
      // if (element.userAccount.email.contains(query)) selected.add(element);
      if (element.phone.contains(query)) selected.add(element);
      // if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<ParentModel>>.value(selected);
  }

  @override
  Future<Response> update(ParentModel parentModel) async {
    Response response = await myDioPATCH(
      url: serverIP + "/api/v1/parents/" + parentModel.id,
      data: parentModel.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }

  @override
  ParentModel parentModel;
}

// class FakeParentService implements ParentService {
//   List<ParentModel> listParentModel = new List<ParentModel>();
//   FakeParentService() {
//     for (int i = 0; i < 15; i++) {
//       int randomInt = Random().nextInt(99999999);
//       listParentModel.add(new ParentModel(
//         id: randomInt.toString(),
//         phone: "06" + randomInt.toString(),
//       ));
//     }
//   }
//   @override
//   Future<Response> add(ParentModel parentModel) {
//     listParentModel.add(parentModel);
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<Response> getAll() {
//     // listParentModel.clear();
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<List<ParentModel>> search(String query) {
//     List<ParentModel> selected = new List<ParentModel>();
//     listParentModel.forEach((element) {
//       if (element.phone.contains(query)) selected.add(element);
//       // if (element.name.contains(query)) selected.add(element);
//     });
//     return Future<List<ParentModel>>.value(selected);
//   }

//   @override
//   Future<Response> delete(int id) {
//     print(listParentModel.length);
//     // for (int i = 0; i < listParentModel.length; i++) {
//     //   if (listParentModel.elementAt(i).id == id) {
//     //     listParentModel.removeAt(i);
//     //   }
//     // }
//     listParentModel.removeWhere((element) {
//       print(element.id.toString() + " == " + id.toString());
//       return element.id == id;
//     });
//     print(listParentModel.length);
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<Response> update(ParentModel parentModel) {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
// }
