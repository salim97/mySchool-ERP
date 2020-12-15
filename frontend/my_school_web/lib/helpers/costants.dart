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
  "Dashboard": {"route name": "Dashboard", "icon": MdiIcons.desktopMacDashboard, "children": null},
  "Teachers": {"route name": "Teachers", "icon": MdiIcons.accountTie, "children": null},
  "Students": {"route name": "Students", "icon": MdiIcons.account, "children": null},
  "Parents": {"route name": "Parents", "icon": MdiIcons.humanFemaleGirl, "children": null},
  "Classes": {
    "icon": MdiIcons.newspaper,
    "children": {
      "Classes": {"route name": "Classes", "icon": MdiIcons.minus, "children": null},
      "Subjects": {"route name": "Subjects", "icon": MdiIcons.minus, "children": null},
      "Subject Mark Fields": {"route name": "Subject Mark Fields", "icon": MdiIcons.minus, "children": null},
      "Marks": {"route name": "Marks", "icon": MdiIcons.minus, "children": null},
      "Exams": {"route name": "Exams", "icon": MdiIcons.minus, "children": null},
      "Time Table": {"route name": "Time Table", "icon": MdiIcons.minus, "children": null},
    }
  },
  "Attendance": {
    "icon": MdiIcons.formatListChecks,
    "children": {
      "Students Attendance": {"route name": "Students Attendance", "icon": MdiIcons.minus, "children": null},
      "Teachers Attendance": {"route name": "Teachers Attendance", "icon": MdiIcons.minus, "children": null},
    }
  },
  "Events": {"route name": "Events", "icon": MdiIcons.calendar, "children": null},
  "Notify": {"route name": "Notify", "icon": MdiIcons.bell, "children": null},
  "General Settings": {
    "icon": MdiIcons.cog,
    "children": {
      "Settings": {"route name": "Settings", "icon": MdiIcons.minus, "children": null},
      "Working Hours": {"route name": "Working Hours", "icon": MdiIcons.minus, "children": null},
    }
  },
};
