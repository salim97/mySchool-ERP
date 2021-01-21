// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/pages/attendance/attendance_view.dart';
import '../ui/pages/documents/documents_view.dart';
import '../ui/pages/examination/examination_view.dart';
import '../ui/pages/home/home_view.dart';
import '../ui/pages/login/login_view.dart';
import '../ui/pages/notice/notice_view.dart';
import '../ui/pages/profile/profile_view.dart';
import '../ui/pages/settings/settings_view.dart';
import '../ui/pages/splash/splash_view.dart';
import '../ui/pages/subjects/subject_screen_view.dart';
import '../ui/pages/teachers/student_teacher_view.dart';
import '../ui/pages/todo_page.dart';

class Routes {
  static const String splashView = '/splash-view';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String toDoPage = '/to-do-page';
  static const String subjectView = '/subject-view';
  static const String studentTeacherView = '/student-teacher-view';
  static const String attendanceView = '/attendance-view';
  static const String settingsView = '/settings-view';
  static const String documentsView = '/documents-view';
  static const String profileView = '/profile-view';
  static const String noticeView = '/notice-view';
  static const String examinationView = '/examination-view';
  static const all = <String>{
    splashView,
    loginView,
    homeView,
    toDoPage,
    subjectView,
    studentTeacherView,
    attendanceView,
    settingsView,
    documentsView,
    profileView,
    noticeView,
    examinationView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.toDoPage, page: ToDoPage),
    RouteDef(Routes.subjectView, page: SubjectView),
    RouteDef(Routes.studentTeacherView, page: StudentTeacherView),
    RouteDef(Routes.attendanceView, page: AttendanceView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.documentsView, page: DocumentsView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.noticeView, page: NoticeView),
    RouteDef(Routes.examinationView, page: ExaminationView),
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
    ToDoPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ToDoPage(),
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
    SettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsView(),
        settings: data,
      );
    },
    DocumentsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DocumentsView(),
        settings: data,
      );
    },
    ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileView(),
        settings: data,
      );
    },
    NoticeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NoticeView(),
        settings: data,
      );
    },
    ExaminationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ExaminationView(),
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
