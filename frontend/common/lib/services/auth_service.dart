import 'dart:convert';

import 'package:common/models/user_model.dart';
import 'package:crypto/crypto.dart';

import '../rest_api.dart';

abstract class AuthService {
  Future<Map> login({String email, String password});

  Future<bool> signout();
}

class FakeAuthService  implements AuthService  {
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
}

// class AuthServiceImpl implements AuthService {
//   @override
//   Future login({String email, String password}) async => throw UnimplementedError();

//   @override
//   Future<bool> signout() {
//     // TODO: implement signout
//     throw UnimplementedError();
//   }
// }
