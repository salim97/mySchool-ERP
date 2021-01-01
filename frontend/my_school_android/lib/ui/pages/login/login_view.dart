import 'package:flutter/material.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:my_school_android/app/router.gr.dart';
import 'package:my_school_android/app/theme.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  var _formKey = GlobalKey<FormState>();
  String user;
  String email;
  Future<String> futureEmail;
  String password = '123456';
  bool isResponse = false;

  Future<String> getEmail(String user) async {}

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (
        BuildContext context,
        LoginViewModel model,
        Widget child,
      ) {
        TextStyle textStyle = Theme.of(context).textTheme.title;

        return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/login_bg.png'),
                          fit: BoxFit.fill,
                        )),
                        child: Center(
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            child: Image.asset(
                              'assets/images/logo.png',
                              // color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 2,
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: textStyle,
                                controller: model.emailController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'please enter a valid email';
                                  }
                                  return value;
                                },
                                decoration: InputDecoration(
                                    hintText: "email",
                                    labelText: "Email",
                                    labelStyle: textStyle,
                                    errorStyle: TextStyle(color: Colors.pinkAccent, fontSize: 15.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                              child: TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                style: textStyle,
                                controller: model.passwordController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'please enter a valid password';
                                  }
                                  return value;
                                },
                                decoration: InputDecoration(
                                    hintText: "password",
                                    labelText: "Password",
                                    labelStyle: textStyle,
                                    errorStyle: TextStyle(color: Colors.pinkAccent, fontSize: 15.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    )),
                              ),
                            ),
                            // Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            CheckboxListTile(
                              contentPadding: EdgeInsets.all(0.0),
                              title: Text("Remember me"),
                              value: false,
                              onChanged: (newValue) {},
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            //     FlatButton(onPressed: () {}, child: Text("Forgot password?"))
                            //   ],
                            // ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: MyTheme.primaryColor,
                                ),
                                child: Text(
                                  "Login",
                                  style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                                ),
                              ),
                              onTap: model.onLoginClicked,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: isResponse == true
                                  ? LinearProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                    )
                                  : Text(''),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
