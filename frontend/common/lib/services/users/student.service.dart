import 'package:dio/dio.dart';

import '../../common.dart';

abstract class StudentService extends RestAPI {
  List<StudentModel> list;
  Future<Response> getAll();
  Future<Response> add(StudentModel studentModel);
  Future<Response> update(StudentModel studentModel);
  Future<List<StudentModel>> search(String query);
  Future<Response> delete(StudentModel id);
  String secret;
}

class StudentServiceImpl extends RestAPI implements StudentService {
  @override
  List<StudentModel> list = new List<StudentModel>();


  @override
  Future<Response> add(StudentModel studentModel) async {
    Response response = await myDioPOST(
      url: serverIP + "/api/v1/students",
      data: studentModel.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }

  @override
  Future<Response> getAll() async {
    Response response = await myDioGET(
      url: serverIP + "/api/v1/students",
    );
    // logger.d(response.data);
    // logger.d(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> _temp = response.data["data"]["data"];
      list.clear();
      _temp.forEach((element) {
        list.add(StudentModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> delete(StudentModel studentModel) async {
    Response response = await myDioDELETE(
      url: serverIP + "/api/v1/students/" + studentModel.id,
    );
    if (response.statusCode == 204) {
      list.removeWhere((element) => element.id == studentModel.id);
    }
    return response;
  }

  @override
  Future<List<StudentModel>> search(String query) {
    List<StudentModel> selected = new List<StudentModel>();
    list.forEach((element) {
      if (element.name.contains(query)) selected.add(element);
      // if (element.userAccount.email.contains(query)) selected.add(element);
      if (element.phone.contains(query)) selected.add(element);
      // if (element.name.contains(query)) selected.add(element);
    });
    return Future<List<StudentModel>>.value(selected);
  }

  @override
  Future<Response> update(StudentModel studentModel) async {
    Response response = await myDioPATCH(
      url: serverIP + "/api/v1/students/" + studentModel.id,
      data: studentModel.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }

  @override
  String secret;
}

// class FakeStudentService extends RestAPI implements StudentService {
//   List<StudentModel> list = new List<StudentModel>();
//   FakeStudentService() {
//     for (int i = 0; i < 15; i++) {
//       int randomInt = Random().nextInt(99999999);
//       list.add(new StudentModel(
//         id: randomInt.toString(),
//         parent_id: randomInt.toString(),
//         rollNo: randomInt.toString(),
//         first_name: "student ",
//         last_name: i.toString(),
//         phone: "06" + randomInt.toString(),
//       ));
//     }
//   }
//   @override
//   Future<Response> add(StudentModel studentModel) {
//     list.add(studentModel);
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<Response> getAll() {
//     // list.clear();
//     return Future<Response>.value(new Response(statusCode: 200));
//   }

//   @override
//   Future<List<StudentModel>> search(String query) {
//     List<StudentModel> selected = new List<StudentModel>();
//     list.forEach((element) {
//       if (element.phone.contains(query)) selected.add(element);
//       // if (element.name.contains(query)) selected.add(element);
//     });
//     return Future<List<StudentModel>>.value(selected);
//   }

//   @override
//   Future<Response> delete(StudentModel id) {
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
//   Future<Response> update(StudentModel studentModel) {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
// }
