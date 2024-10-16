// firebase
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// final Future<FirebaseApp> initialization = Firebase.initializeApp();

// FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
// FirebaseAuth auth = FirebaseAuth.instance;

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Map menuAdmin = {
  "Dashboard": {"route name": "/dashboard-view", "icon": MdiIcons.desktopMacDashboard, "children": null},
  "Teachers": {"route name": "/teachers-view", "icon": MdiIcons.accountTie, "children": null},
  "Students": {"route name": "/students-view", "icon": MdiIcons.account, "children": null},
  "Parents": {"route name": "/parents-view", "icon": MdiIcons.humanFemaleGirl, "children": null},
  "divider1": "divider",
  "Academics": {
    "icon": MdiIcons.newspaper,
    "children": {
      "Classes": {"route name": "/class-room-view", "icon": MdiIcons.minus, "children": null},
      "Groups": {"route name": "/group-view", "icon": MdiIcons.minus, "children": null},
      "Assign Student to Group": {"route name": "/student-group-view", "icon": MdiIcons.minus, "children": null},
      "Sections": {"route name": "/section-view", "icon": MdiIcons.minus, "children": null},
      "Subjects": {"route name": "/subject-view", "icon": MdiIcons.minus, "children": null},
      "Assign Teacher to Subject": {"route name": "/teacher-subject-view", "icon": MdiIcons.minus, "children": null},
      "Time Table": {"route name": "/time-table-view", "icon": MdiIcons.minus, "children": null},
      // "Subject Mark Fields": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      // "Marks": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      // "Exams": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
    }
  },
  "Attendance": {
    "icon": MdiIcons.formatListChecks,
    "children": {
      "Students Attendance": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Teachers Attendance": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
    }
  },
  "divider2": "divider",
  "Events": {"route name": "/to-do-page", "icon": MdiIcons.calendar, "children": null},
  "Notify": {"route name": "/notification-view", "icon": MdiIcons.bell, "children": null},
  "General Settings": {
    "icon": MdiIcons.cog,
    "children": {
      "Settings": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Working hours": {"route name": "/working-hours-view", "icon": MdiIcons.minus, "children": null},
    }
  },
};
