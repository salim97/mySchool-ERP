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
  "Tableau de Bord": {"route name": "/dashboard-view", "icon": MdiIcons.desktopMacDashboard, "children": null},
  "Enseignantes": {"route name": "/teachers-view", "icon": MdiIcons.accountTie, "children": null},
  "Students": {"route name": "/students-view", "icon": MdiIcons.account, "children": null},
  "Élèves": {"route name": "/to-do-page", "icon": MdiIcons.humanFemaleGirl, "children": null},
  "Des classes": {
    "icon": MdiIcons.newspaper,
    "children": {
      "Classes": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Subjects": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Subject Mark Fields": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Marks": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Exams": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Time Table": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
    }
  },
  "Présence": {
    "icon": MdiIcons.formatListChecks,
    "children": {
      "Students Attendance": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Teachers Attendance": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
    }
  },
  "Événements": {"route name": "/to-do-page", "icon": MdiIcons.calendar, "children": null},
  "Notifier": {"route name": "/to-do-page", "icon": MdiIcons.bell, "children": null},
  "Réglages Généraux": {
    "icon": MdiIcons.cog,
    "children": {
      "Paramètres": {"route name": "/to-do-page", "icon": MdiIcons.minus, "children": null},
      "Heures d'ouverture": {"route name": "/working-hours-view", "icon": MdiIcons.minus, "children": null},
    }
  },
};
