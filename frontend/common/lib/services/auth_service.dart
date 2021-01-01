import 'dart:convert';

import 'package:common/models/user_model.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../rest_api.dart';

abstract class AuthService {
  UserModel userModel;
  Future<Response> login({String email, String password});
  Future<Response> signup(UserModel userModel);
  Future<Response> logout();
  Future<Response> me();
}

class FakeAuthService implements AuthService {
  UserModel userModel;
  @override
  Future<Response> login({String email, String password}) async {
    userModel = new UserModel();
    userModel.email = email;
    userModel.id = "1";
    userModel.role = "admin";
    return Response(statusCode: 200);
  }

  @override
  Future<Response> logout() async {
    await Future.delayed(Duration(seconds: 2), () {
      return;
    });
    return Response(statusCode: 200);
    ;
  }

  @override
  Future<Response> signup(UserModel userModel) {
    // TODO: implement signup
    throw UnimplementedError();
  }

  @override
  Future<Response> me() {
    // TODO: implement me
    throw UnimplementedError();
  }
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
    );
    if (response.statusCode == 200) {
      userModel = new UserModel.fromJson(response.data["data"]["user"]);
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
}
