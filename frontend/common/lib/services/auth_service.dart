import 'dart:convert';

import 'package:common/models/user_model.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../rest_api.dart';

abstract class AuthService {
  Future<Map> login({String email, String password});
  Future<Map> signup(UserModel userModel);
  Future<bool> signout();
}

class FakeAuthService implements AuthService {
  @override
  Future<Map> login({String email, String password}) async {
    UserModel userModel = new UserModel();
    userModel.token = sha256.convert(utf8.encode(email + password)).toString();
    userModel.email = email;
    userModel.id = 1;
    userModel.role = "admin";

    return userModel.toJson();
  }

  @override
  Future<bool> signout() async {
    await Future.delayed(Duration(seconds: 2), () {
      return;
    });
    return true;
  }

  @override
  Future<Map> signup(UserModel userModel) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}

class AuthServiceImpl extends RestAPI implements AuthService {
  @override
  Future<Map> login({String email, String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }

  @override
  Future<Map> signup(UserModel userModel) async {
    Response response = await myDioPOST(
      url: "127.0.0.1:3000/auth/signup",
      data: {
        "name": userModel.fullName,
        "auth_type": userModel.auth_type,
        "email": userModel.email,
        "password": userModel.password,
        "role": userModel.role,
      },
    );
    var l = new Logger();
    l.d(response.data);
  }
}
