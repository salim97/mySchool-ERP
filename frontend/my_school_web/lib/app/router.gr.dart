// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../ui/pages/dashboard/dashboard_view.dart';
import '../ui/pages/home/home_view.dart';
import '../ui/pages/login/login_view.dart';
import '../ui/pages/students/add_student_view.dart';
import '../ui/pages/students/students_view.dart';
import '../ui/pages/teachers/add_teacher_view.dart';
import '../ui/pages/teachers/teachers_view.dart';

class Routes {
  static const String homeView = '/home-view';
  static const String dashboardView = '/dashboard-view';
  static const String teachersView = '/teachers-view';
  static const String addTeacherView = '/add-teacher-view';
  static const String studentsView = '/students-view';
  static const String addStudentView = '/add-student-view';
  static const String loginView = '/login-view';
  static const String appPagesController = '/app-pages-controller';
  static const all = <String>{
    homeView,
    dashboardView,
    teachersView,
    addTeacherView,
    studentsView,
    addStudentView,
    loginView,
    appPagesController,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.dashboardView, page: DashboardView),
    RouteDef(Routes.teachersView, page: TeachersView),
    RouteDef(Routes.addTeacherView, page: AddTeacherView),
    RouteDef(Routes.studentsView, page: StudentsView),
    RouteDef(Routes.addStudentView, page: AddStudentView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.appPagesController, page: AppPagesController),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    DashboardView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DashboardView(),
        settings: data,
      );
    },
    TeachersView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TeachersView(),
        settings: data,
      );
    },
    AddTeacherView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddTeacherView(),
        settings: data,
      );
    },
    StudentsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StudentsView(),
        settings: data,
      );
    },
    AddStudentView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddStudentView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    AppPagesController: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AppPagesController(),
        settings: data,
      );
    },
  };
}
