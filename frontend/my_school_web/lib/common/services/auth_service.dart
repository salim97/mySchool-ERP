import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../common.dart';
import '../rest_api.dart';

abstract class AuthService extends RestAPI {
  UserModel userModel;
  Future<Response> login({String email, String password});
  Future<Response> signup(UserModel userModel);
  Future<Response> logout();
  Future<Response> me();
  Future<Response> updateUser(UserModel userModel);
}

class AuthServiceImpl extends RestAPI implements AuthService {
  UserModel userModel;
  @override
  Future<Response> login({String email, String password}) async {
    Response response = await myDioPOST(
      url: serverIP + "/api/v1/auth/login",
      data: {
        "email": email,
        "password": password,
      },
      isAuthEnabled: false,
    );
    if (response.statusCode == 200) {
      setToken(response.data["token"]);
      userModel = new UserModel.fromJson(response.data["data"]["user"]);
      // final cookies = response.headers.map['set-cookie'];
      // if (cookies.isNotEmpty) {
      //   String token = cookies[0].split(";").first.split("=").last;
      //   setToken(token);
      // }
    }
    return response;
  }

  @override
  Future<Response> logout() async {
    Response response = await myDioGET(
      url: serverIP + "/api/v1/auth/logout",
    );
    return response;
  }

  @override
  Future<Response> signup(UserModel userModel) async {
    Response response = await myDioPOST(
      url: serverIP + "/api/v1/auth/signup",
      data: {
        "name": userModel.name,
        "email": userModel.email,
        "password": userModel.password,
        "passwordConfirm": userModel.password,
        "role": userModel.role,
      },
    );
    return response;
  }

  @override
  Future<Response> me() async {
    Response response = await myDioGET(
      url: serverIP + "/api/v1/auth/me",
    );
    if (response.statusCode == 200) {
      userModel = new UserModel.fromJson(response.data["data"]["data"]);
    }
    return response;
  }

  @override
  Future<Response> updateUser(UserModel userModel) async {
    Response response = await myDioPATCH(url: serverIP + "/api/v1/auth/" + userModel.id, data: {
      "name": userModel.name,
      "photo": userModel.photo,
      "email": userModel.email,
      //"password" : userModel.password,
      //"passwordConfirm" : userModel.password,
      // "role" : userModel.role,
    });
    if (response.statusCode == 200) {
      userModel = new UserModel.fromJson(response.data["data"]["data"]);
    }
    return response;
  }

}

// class FakeAuthService extends RestAPI implements AuthService {
//   UserModel userModel;
//   @override
//   Future<Response> login({String email, String password}) async {
//     userModel = new UserModel();
//     userModel.email = email;
//     userModel.id = "1";
//     userModel.role = "admin";
//     return Response(statusCode: 200);
//   }

//   @override
//   Future<Response> logout() async {
//     await Future.delayed(Duration(seconds: 2), () {
//       return;
//     });
//     return Response(statusCode: 200);
//     ;
//   }

//   @override
//   Future<Response> signup(UserModel userModel) {
//     // TODO: implement signup
//     throw UnimplementedError();
//   }

//   @override
//   Future<Response> me() {
//     // TODO: implement me
//     throw UnimplementedError();
//   }

//   @override
//   Future<Response> updateUser(UserModel userModel) {
//     // TODO: implement updateMe
//     throw UnimplementedError();
//   }
// }
