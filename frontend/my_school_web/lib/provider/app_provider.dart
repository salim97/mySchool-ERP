import 'package:common/common.dart';
import 'package:my_school_web/app/helpers/costants.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';

// enum DisplayedPage { HOME, PRODUCTS, ORDERS, USERS, BRANDS, CATEGORIES }
// enum DisplayedPageForAdmin { Dashboard, Teachers, Students, Parents, Classes, Attendance }

class AppProvider with ChangeNotifier {
  Map sideMenu;
  String currentPage;

  ParentService parentService;
  StudentModel studentModel;
  AuthService authService;

  AppProvider.init() {
    // parentService = locator<ParentService>();
    // studentModel = locator<StudentModel>();
    // authService = locator<AuthService>();
    sideMenu = menuAdmin;
    _getRevenue();
    changeCurrentPage(sideMenu.keys.first);
  }

  changeCurrentPage(String newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  void _getRevenue() async {}
}
