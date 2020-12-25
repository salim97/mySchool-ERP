// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/pages/attendance/attendance_view.dart';
import '../ui/pages/home/home_view.dart';
import '../ui/pages/homework/homework_view.dart';
import '../ui/pages/login/login_view.dart';
import '../ui/pages/routine/routine_view.dart';
import '../ui/pages/splash/splash_view.dart';
import '../ui/pages/subjects/subject_screen_view.dart';
import '../ui/pages/teachers/student_teacher_view.dart';
import '../ui/pages/todo_page.dart';

class Routes {
  static const String splashView = '/splash-view';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String routineView = '/routine-view';
  static const String toDoPage = '/to-do-page';
  static const String homeWorkView = '/home-work-view';
  static const String subjectView = '/subject-view';
  static const String studentTeacherView = '/student-teacher-view';
  static const String attendanceView = '/attendance-view';
  static const all = <String>{
    splashView,
    loginView,
    homeView,
    routineView,
    toDoPage,
    homeWorkView,
    subjectView,
    studentTeacherView,
    attendanceView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.routineView, page: RoutineView),
    RouteDef(Routes.toDoPage, page: ToDoPage),
    RouteDef(Routes.homeWorkView, page: HomeWorkView),
    RouteDef(Routes.subjectView, page: SubjectView),
    RouteDef(Routes.studentTeacherView, page: StudentTeacherView),
    RouteDef(Routes.attendanceView, page: AttendanceView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    RoutineView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RoutineView(),
        settings: data,
      );
    },
    ToDoPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ToDoPage(),
        settings: data,
      );
    },
    HomeWorkView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeWorkView(),
        settings: data,
      );
    },
    SubjectView: (data) {
      final args = data.getArgs<SubjectViewArguments>(
        orElse: () => SubjectViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SubjectView(id: args.id),
        settings: data,
      );
    },
    StudentTeacherView: (data) {
      final args = data.getArgs<StudentTeacherViewArguments>(
        orElse: () => StudentTeacherViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => StudentTeacherView(id: args.id),
        settings: data,
      );
    },
    AttendanceView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AttendanceView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SubjectView arguments holder class
class SubjectViewArguments {
  final String id;
  SubjectViewArguments({this.id});
}

/// StudentTeacherView arguments holder class
class StudentTeacherViewArguments {
  final String id;
  StudentTeacherViewArguments({this.id});
}
