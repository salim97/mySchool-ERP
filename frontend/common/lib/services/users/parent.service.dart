import 'dart:math';

import 'package:dio/dio.dart';

import '../../common.dart';
import '../../rest_api.dart';

abstract class ParentService {
  List<ParentModel> list;
  ParentModel parentModel;
  Future<Response> getAll();
  Future<Response> add(ParentModel parentModel);
  Future<Response> update(ParentModel parentModel);
  Future<List<ParentModel>> search(String query);
  Future<Response> delete(ParentModel id);
}

class ParentServiceImpl extends RestAPI implements ParentService {
  @override
  List<ParentModel> list = new List<ParentModel>();

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
      List<dynamic> _temp = response.data["data"]["data"];
      list.clear();
      _temp.forEach((element) {
        list.add(ParentModel.fromJson(element));
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
      list.removeWhere((element) => element.id == parentModel.id);
    }
    return response;
  }

  @override
  Future<List<ParentModel>> search(String query) {
    List<ParentModel> selected = new List<ParentModel>();
    list.forEach((element) {
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

class ParentServiceFake extends RestAPI implements ParentService {
  @override
  List<ParentModel> list = new List<ParentModel>();

  ParentServiceFake() {
    list.add(ParentModel(id: "01", name: "Salim", phone: "05 *** ***"));
    list.add(ParentModel(id: "02", name: "Amine", phone: "05 *** ***"));
    list.add(ParentModel(id: "03", name: "Chakib", phone: "05 *** ***"));
    list.add(ParentModel(id: "04", name: "Kader", phone: "05 *** ***"));
  }

  @override
  Future<Response> add(ParentModel parentModel) async {
    list.add(parentModel);
    return Response(statusCode: 201);
  }

  @override
  Future<Response> getAll() async {
    return Response(statusCode: 200);
  }

  @override
  Future<Response> delete(ParentModel parentModel) async {
    list.removeWhere((element) => element.id == parentModel.id);

    return Response(statusCode: 201);
  }

  @override
  Future<List<ParentModel>> search(String query) {
    List<ParentModel> selected = new List<ParentModel>();
    list.forEach((element) {
      if (element.name.contains(query)) selected.add(element);
      // if (element.userAccount.email.contains(query)) selected.add(element);
      if (element.phone.contains(query)) selected.add(element);
      // if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<ParentModel>>.value(selected);
  }

  @override
  Future<Response> update(ParentModel parentModel) async {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).id == parentModel.id) list[i] = parentModel;
    }
    return Response(statusCode: 201);
  }

  @override
  ParentModel parentModel;
}

// class FakeParentService implements ParentService {
//   List<ParentModel> list = new List<ParentModel>();
//   FakeParentService() {
//     for (int i = 0; i < 15; i++) {
//       int randomInt = Random().nextInt(99999999);
//       list.add(new ParentModel(
//         id: randomInt.toString(),
//         phone: "06" + randomInt.toString(),
//       ));
//     }
//   }
//   @override
//   Future<Response> add(ParentModel parentModel) {
//     list.add(parentModel);
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<Response> getAll() {
//     // list.clear();
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<List<ParentModel>> search(String query) {
//     List<ParentModel> selected = new List<ParentModel>();
//     list.forEach((element) {
//       if (element.phone.contains(query)) selected.add(element);
//       // if (element.name.contains(query)) selected.add(element);
//     });
//     return Future<List<ParentModel>>.value(selected);
//   }

//   @override
//   Future<Response> delete(int id) {
//     print(list.length);
//     // for (int i = 0; i < list.length; i++) {
//     //   if (list.elementAt(i).id == id) {
//     //     list.removeAt(i);
//     //   }
//     // }
//     list.removeWhere((element) {
//       print(element.id.toString() + " == " + id.toString());
//       return element.id == id;
//     });
//     print(list.length);
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<Response> update(ParentModel parentModel) {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
// }
