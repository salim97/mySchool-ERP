// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../ui/pages/WorkingHours/working_hours.view.dart';
import '../ui/pages/academics/classRoom/classRoom.view.dart';
import '../ui/pages/dashboard/dashboard.view.dart';
import '../ui/pages/home/home.view.dart';
import '../ui/pages/login/login.view.dart';
import '../ui/pages/parents/add_parent.view.dart';
import '../ui/pages/parents/parents.view.dart';
import '../ui/pages/parents/select_child.view.dart';
import '../ui/pages/splash/splash.view.dart';
import '../ui/pages/students/add_student.view.dart';
import '../ui/pages/students/students.view.dart';
import '../ui/pages/teachers/add_teacher.view.dart';
import '../ui/pages/teachers/teachers.view.dart';
import '../ui/pages/todo_page.view.dart';

class Routes {
  static const String splashView = '/splash-view';
  static const String loginView = '/login-view';
  static const String appPagesController = '/app-pages-controller';
  static const String homeView = '/home-view';
  static const String dashboardView = '/dashboard-view';
  static const String teachersView = '/teachers-view';
  static const String addTeacherView = '/add-teacher-view';
  static const String studentsView = '/students-view';
  static const String addStudentView = '/add-student-view';
  static const String parentsView = '/parents-view';
  static const String addParentView = '/add-parent-view';
  static const String selectStudentView = '/select-student-view';
  static const String workingHoursView = '/working-hours-view';
  static const String toDoPage = '/to-do-page';
  static const String classRoomView = '/class-room-view';
  static const all = <String>{
    splashView,
    loginView,
    appPagesController,
    homeView,
    dashboardView,
    teachersView,
    addTeacherView,
    studentsView,
    addStudentView,
    parentsView,
    addParentView,
    selectStudentView,
    workingHoursView,
    toDoPage,
    classRoomView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.appPagesController, page: AppPagesController),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.dashboardView, page: DashboardView),
    RouteDef(Routes.teachersView, page: TeachersView),
    RouteDef(Routes.addTeacherView, page: AddTeacherView),
    RouteDef(Routes.studentsView, page: StudentsView),
    RouteDef(Routes.addStudentView, page: AddStudentView),
    RouteDef(Routes.parentsView, page: ParentsView),
    RouteDef(Routes.addParentView, page: AddParentView),
    RouteDef(Routes.selectStudentView, page: SelectStudentView),
    RouteDef(Routes.workingHoursView, page: WorkingHoursView),
    RouteDef(Routes.toDoPage, page: ToDoPage),
    RouteDef(Routes.classRoomView, page: ClassRoomView),
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
    AppPagesController: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AppPagesController(),
        settings: data,
      );
    },
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
    ParentsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ParentsView(),
        settings: data,
      );
    },
    AddParentView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddParentView(),
        settings: data,
      );
    },
    SelectStudentView: (data) {
      final args = data.getArgs<SelectStudentViewArguments>(
        orElse: () => SelectStudentViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SelectStudentView(key: args.key),
        settings: data,
      );
    },
    WorkingHoursView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => WorkingHoursView(),
        settings: data,
      );
    },
    ToDoPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ToDoPage(),
        settings: data,
      );
    },
    ClassRoomView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ClassRoomView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SelectStudentView arguments holder class
class SelectStudentViewArguments {
  final Key key;
  SelectStudentViewArguments({this.key});
}
