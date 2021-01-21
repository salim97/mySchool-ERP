import 'package:my_school_web/common/common.dart';
import 'package:my_school_web/app/helpers/costants.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

// enum DisplayedPage { HOME, PRODUCTS, ORDERS, USERS, BRANDS, CATEGORIES }
// enum DisplayedPageForAdmin { Dashboard, Teachers, Students, Parents, Classes, Attendance }

class AppProvider with ChangeNotifier {
  Map sideMenu;
  String currentPage;

  String getNameOfThisRoute(String route) {
    String currentRoute = "NULL";
    sideMenu.forEach((key1, value1) {
      if (value1["children"] == null) {
        if (value1["route name"] == route) currentRoute = key1;
        return;
      }
      Map children = value1["children"];
      children.forEach((key2, value2) {
        if (value2["route name"] == route) currentRoute = key2;
        return;
      });
    });
    return currentRoute;
  }

  AppProvider.init() {
    sideMenu = menuAdmin;
  }
}
