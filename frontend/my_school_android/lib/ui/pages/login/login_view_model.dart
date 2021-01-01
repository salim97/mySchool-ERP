import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  init() async {
    emailController.text = "admin1@email.com";
    passwordController.text = "azerty2020";
  }

  var l = new Logger();
  onLoginClicked() async {
    // _navigationService.replaceWith(Routes.homeView);

    Response response = await _authService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    l.d(response.statusCode);
    l.d(_authService.userModel.toJson());
    Future.delayed(Duration(seconds: 3), () async {
      Response r;

      r = await _authService.me();
      l.d(r.statusCode);

      r = await _authService.logout();
      l.d(r.statusCode);

      r = await _authService.me();
      l.d(r.statusCode);
    });
    // l.d(response);
    // final AuthService authService = locator<AuthService>();
    // Map json = await authService.login(email: email, password: password);
    // var logger = Logger();

    // logger.d(json);
    // print(json);
//                             if(email.length > 5 && password.length > 5){
//                               setState(() {
//                                 isResponse = true;
//                               });
//                               Login(email, password).getData(context).then((result)=>{
// //                                if(result){
// //                                  debugPrint('success')
// //                                }
//                               });
//                             }else{
//                               setState(() {
//                                 isResponse = false;
//                               });
//                               Utils.showToast('invalid email and password');
//                             }
//                            setState(() {
//                              if (_formKey.currentState.validate()) {
//
//                                Utils.showToast('${emailController.text}  ${passwordController.text}');
//
//                                String email = emailController.text;
//                                String password = passwordController.text;
//
//                                debugPrint('$email  $password');
//
//                                Login(email, password).getData(context).then((result)=>{
//                                  if(result){
//                                    debugPrint('success')
//                                  }
//                                });
//                              }
//                            });
  }
}
