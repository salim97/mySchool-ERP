library splash_view;

import 'dart:async';

import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:my_school_web/common/common.dart';
import 'package:my_school_web/main.dart';
import 'package:my_school_web/provider/auth.provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'splash.view.model.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 30.0, end: 90.0).animate(controller);
    controller.forward();

    if (production) {
      locator<AuthService>().login(email: "admin@email.com", password: "azerty2020").then((response) async {
        Future.delayed(Duration(seconds: 1), () async {
          AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
          authProvider.status = Status.Authenticated;
          authProvider.notifyListeners();
        });
      });
    } else {
      Future.delayed(Duration(seconds: 1), () async {
        AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.status = Status.Unauthenticated;
        authProvider.notifyListeners();
      });
    }
    // Future.delayed(Duration(seconds: 0), () async {

    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> getBooleanValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => SplashViewModel(),
        onModelReady: (model) {
          // Do something once your model is initialized
        },
        builder: (context, model, child) {
          return Scaffold(
            body: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/splash_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                'Welcome to',
                                style: TextStyle(
                                  color: Color(0xFF727FC8),
                                  fontSize: 20.0,
                                  fontFamily: 'popins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            AnimatedBuilder(
                              animation: animation,
                              builder: (context, child) {
                                return Container(
                                  height: animation.value,
                                  width: animation.value,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: ExactAssetImage('assets/images/logo-white.png'),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 60.0),
                              child: Text(
                                'UNLIMITED EDUCATION ERP',
                                style:
                                    TextStyle(color: Color(0xFF727FC8), fontSize: 10.0, fontFamily: 'popins', fontStyle: FontStyle.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 80.0, left: 40, right: 40),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}