import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_school_web/common/common.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  // User _user;
  // Status status = Status.Uninitialized;
  // Status status = Status.Unauthenticated;
  Status status = Status.Authenticated;
  // UserModel _userModel;

//  getter
  // UserModel get userModel => _userModel;
  // Status get status => _status;
  // User get user => _user;

  // public variables
  // final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  String userProfileImage = "";

  AuthProvider.initialize() {
    if (DEVELOPMENT_MODE()) {
      status = Status.Authenticated;
    } else {
      status = Status.Unauthenticated;
    }
    email.text = "admin@email.com";
    password.text = "azerty2020";
    notifyListeners();
    _fireSetUp();
  }

  _fireSetUp() async {
    // await initialization.then((value) {
    //   auth.authStateChanges().listen(_onStateChanged);
    // });
  }

  Future<bool> signIn() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // try {
    //   _status = Status.Authenticating;
    //   notifyListeners();
    //   await auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((value) async {
    //     await prefs.setString("id", value.user.uid);
    //   });
    //   return true;
    // } catch (e) {
    //   _status = Status.Unauthenticated;
    //   notifyListeners();
    //   print(e.toString());
    //   return false;
    // }
  }

  Future<bool> signUp() async {
    // try {
    //   _status = Status.Authenticating;
    //   notifyListeners();
    //   await auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result) async {
    //     SharedPreferences prefs = await SharedPreferences.getInstance();
    //     await prefs.setString("id", result.user.uid);
    //     _userServices.createUser(
    //       id: result.user.uid,
    //       name: name.text.trim(),
    //       email: email.text.trim(),
    //     );
    //   });
    //   return true;
    // } catch (e) {
    //   _status = Status.Unauthenticated;
    //   notifyListeners();
    //   print(e.toString());
    //   return false;
    // }
  }

  Future signOut() async {
    // auth.signOut();
    // _status = Status.Unauthenticated;
    // notifyListeners();
    // return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reloadUserModel() async {
    // _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  updateUserData(Map<String, dynamic> data) async {}

  // _onStateChanged(User firebaseUser) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (firebaseUser == null) {
  //     _status = Status.Unauthenticated;
  //   } else {
  //     _user = firebaseUser;
  //     await prefs.setString("id", firebaseUser.uid);

  //     _userModel = await _userServices.getUserById(user.uid).then((value) {
  //       _status = Status.Authenticated;
  //       return value;
  //     });
  //   }
  //   notifyListeners();
  // }

  String validateEmail(String value) {
    value = value.trim();

    if (email.text != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }
}
