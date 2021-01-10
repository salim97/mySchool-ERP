import 'package:my_school_web/common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:my_school_web/main.dart';
import 'package:my_school_web/provider/auth.provider.dart';

import 'package:my_school_web/ui/widgets/custom_text.dart';
import 'package:my_school_web/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/ui/widgets/myWidgets/myDialog.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'login.view.model.dart';

class LoginView extends StatelessWidget {
  // final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onModelReady: (model) {
          // Do something once your model is initialized

          // if (production)
        },
        builder: (context, model, child) {
          return Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.indigo.shade600])),
            child: authProvider.status == Status.Authenticating
                ? Loading()
                : Scaffold(
                    // key: _key,
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: Container(
                        color: Colors.red,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, 3), blurRadius: 24)]),
                          height: 400,
                          width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: currentVersion,
                                size: 18,
                                weight: FontWeight.normal,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "LOGIN",
                                size: 22,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.grey[200]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: authProvider.email,
                                      decoration:
                                          InputDecoration(border: InputBorder.none, hintText: 'Email', icon: Icon(Icons.email_outlined)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.grey[200]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: authProvider.password,
                                      decoration:
                                          InputDecoration(border: InputBorder.none, hintText: 'Password', icon: Icon(Icons.lock_open)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomText(
                                      text: "Forgot password?",
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.indigo),
                                  child: FlatButton(
                                    onPressed: () async {
                                      // DialogService _dialogService = await locator<DialogService>();
                                      // await _dialogService.showDialog(
                                      //   title: 'Test Dialog Title',
                                      //   description: 'Test Dialog Description',
                                      //   dialogPlatform: DialogPlatform.Cupertino,
                                      // );
                                      dynamic rr = await MyDialogs.timeTableAdd(
                                        context: context,
                                        roomList: ["a", "b"],
                                        subjectList: ["c", "d", "e", "f"],
                                        teacherList: ["sdfsdf", "sdf"],
                                      );
                                      print(rr);
                                      return;

                                      authProvider.status = Status.Authenticating;
                                      authProvider.notifyListeners();
                                      Response response = await locator<AuthService>()
                                          .login(email: authProvider.email.text, password: authProvider.password.text);
                                      if (response.statusCode == 200) {
                                        authProvider.status = Status.Authenticated;
                                      } else {
                                        authProvider.status = Status.Unauthenticated;
                                      }
                                      authProvider.notifyListeners();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: "LOGIN",
                                            size: 22,
                                            color: Colors.white,
                                            weight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: "Do not have an account? ",
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          // locator<NavigationService>().globalNavigateTo("RegistrationRoute", context);
                                          // Navigator.of(context).pushNamed("RegistrationRoute");
                                        },
                                        child: CustomText(
                                          text: "Sign up here. ",
                                          size: 16,
                                          color: Colors.indigo,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
