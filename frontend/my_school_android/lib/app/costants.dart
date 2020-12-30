// firebase
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// final Future<FirebaseApp> initialization = Firebase.initializeApp();

// FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
// FirebaseAuth auth = FirebaseAuth.instance;

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Constants {
  static Map menuStudent = {
    "Profile": {"route name": "/profile-view", "icon": "assets/images/profile.png", "children": null},
    // "Fees": {"route name": "/to-do-page", "icon": 'assets/images/fees_icon.png', "children": null},
    "Routine": {"route name": "/routine-view", "icon": 'assets/images/routine.png', "children": null},
    "Homework": {"route name": "/home-work-view", "icon": 'assets/images/homework.png', "children": null},
    "My Documents": {"route name": "/documents-view", "icon": 'assets/images/notice.png', "children": null},
    // "Timeline": {"route name": "/to-do-page", "icon": 'assets/images/timeline.png', "children": null},
    "Attendance": {"route name": "/attendance-view", "icon": 'assets/images/attendance.png', "children": null},
    "Examination": {"route name": "/examination-view", "icon": 'assets/images/examination.png', "children": null},
    // "Online Exam": {"route name": "/to-do-page", "icon": 'assets/images/onlineexam.png', "children": null},
    "Notice board": {"route name": "/notice-view", "icon": 'assets/images/notice.png', "children": null},
    "Subjects": {"route name": "/subject-view", "icon": 'assets/images/subjects.png', "children": null},
    "Teacher": {"route name": "/student-teacher-view", "icon": 'assets/images/teacher.png', "children": null},
    // "Library": {"route name": "/to-do-page", "icon":'assets/images/library.png', "children": null},
    // "Transport": {"route name": "/to-do-page", "icon": 'assets/images/transport.png', "children": null},
    // "Dormitory": {"route name": "/to-do-page", "icon": 'assets/images/dormitory.png', "children": null},
    "Settings": {"route name": "/settings-view", "icon": 'assets/images/settings-white.png', "children": null},
  };

  static Map menuTeacher = {
    "Students": {"route name": "/to-do-page", "icon": "assets/images/students.png", "children": null},
    "Academic": {"route name": "/to-do-page", "icon": 'assets/images/academics.png', "children": null},
    "Attendance": {"route name": "/to-do-page", "icon": 'assets/images/attendance.png', "children": null},
    "Leave": {"route name": "/to-do-page", "icon": 'assets/images/leave.png', "children": null},
    "Contents": {"route name": "/to-do-page", "icon": 'assets/images/contents.png', "children": null},
    "Notice": {"route name": "/to-do-page", "icon": 'assets/images/notice.png', "children": null},
    "Library": {"route name": "/to-do-page", "icon": 'assets/images/library.png', "children": null},
    "Homework": {"route name": "/to-do-page", "icon": 'assets/images/homework.png', "children": null},
    "About": {"route name": "/to-do-page", "icon": 'assets/images/about.png', "children": null},
    "Settings": {"route name": "/settings-view", "icon": 'assets/images/settings.png', "children": null},
  };

  static Map menuAdmin = {
    "Students": {"route name": "/to-do-page", "icon": "assets/images/students.png", "children": null},
    "Leave": {"route name": "/to-do-page", "icon": 'assets/images/leave.png', "children": null},
    "Stuff": {"route name": "/to-do-page", "icon": 'assets/images/staff.png', "children": null},
    "Dormitory": {"route name": "/to-do-page", "icon": 'assets/images/dormitory.png', "children": null},
    "Attendance": {"route name": "/attendance-view", "icon": 'assets/images/attendance.png', "children": null},
    "Fees": {"route name": "/to-do-page", "icon": 'assets/images/fees_icon.png', "children": null},
    "Library": {"route name": "/to-do-page", "icon": 'assets/images/library.png', "children": null},
    "Transport": {"route name": "/to-do-page", "icon": 'assets/images/transport.png', "children": null},
    "Settings": {"route name": "/settings-view", "icon": 'assets/images/settings.png', "children": null},
  };

  static Map menuParent = {
    "Child": {"route name": "/to-do-page", "icon": "assets/images/students.png", "children": null},
    "Routine": {"route name": "/routine-view", "icon": 'assets/images/routine.png', "children": null},
    "About": {"route name": "/to-do-page", "icon": 'assets/images/about.png', "children": null},
    "Settings": {"route name": "/settings-view", "icon": 'assets/images/settings.png', "children": null},
  };

  static Map menuHomeWork = {
    "Add HW": {"route name": "/to-do-page", "icon": "assets/images/addhw.png", "children": null},
    "HW List": {"route name": "/to-do-page", "icon": 'assets/images/hwlist.png', "children": null},
  };

  static Map menuContent = {
    "Add Content": {"route name": "/to-do-page", "icon": "assets/images/addhw.png", "children": null},
    "Content List": {"route name": "/to-do-page", "icon": 'assets/images/hwlist.png', "children": null},
  };

  static Map menuAcademics = {
    "My Routine": {"route name": "/to-do-page", "icon": "assets/images/myroutine.png", "children": null},
    "Class Routine": {"route name": "/to-do-page", "icon": 'assets/images/classroutine.png', "children": null},
    "Subjects": {"route name": "/to-do-page", "icon": 'assets/images/subjects.png', "children": null},
  };

  static Map menuAttendance = {
    "Class Attendance": {"route name": "/to-do-page", "icon": "assets/images/classattendance.png", "children": null},
    "Search Attendance": {"route name": "/to-do-page", "icon": 'assets/images/searchattendance.png', "children": null},
    "My Attendance": {"route name": "/to-do-page", "icon": 'assets/images/myattendance.png', "children": null},
  };

  static Map menuExamination = {
    "Schedule": {"route name": "/to-do-page", "icon": "assets/images/classroutine.png", "children": null},
    "Result": {"route name": "/to-do-page", "icon": 'assets/images/examination.png', "children": null},
  };
}
