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
    "Profile": {"route name": "/to-do-page", "icon": "assets/images/profile.png", "children": null},
    // "Fees": {"route name": "/to-do-page", "icon": 'assets/images/fees_icon.png', "children": null},
    "Routine": {"route name": "/routine-view", "icon": 'assets/images/routine.png', "children": null},
    "Homework": {"route name": "/home-work-view", "icon": 'assets/images/homework.png', "children": null},
    "Timeline": {"route name": "/to-do-page", "icon": 'assets/images/timeline.png', "children": null},
    "Attendance": {"route name": "/attendance-view", "icon": 'assets/images/attendance.png', "children": null},
    "Examination": {"route name": "/to-do-page", "icon": 'assets/images/examination.png', "children": null},
    // "Online Exam": {"route name": "/to-do-page", "icon": 'assets/images/onlineexam.png', "children": null},
    "Notice": {"route name": "/to-do-page", "icon": 'assets/images/notice.png', "children": null},
    "Subjects": {"route name": "/subject-view", "icon": 'assets/images/subjects.png', "children": null},
    "Teacher": {"route name": "/student-teacher-view", "icon": 'assets/images/teacher.png', "children": null},
    // "Library": {"route name": "/to-do-page", "icon":'assets/images/library.png', "children": null},
    // "Transport": {"route name": "/to-do-page", "icon": 'assets/images/transport.png', "children": null},
    // "Dormitory": {"route name": "/to-do-page", "icon": 'assets/images/dormitory.png', "children": null},
    "Settings": {"route name": "/to-do-page", "icon": 'assets/images/addhw.png', "children": null},
  };
}
