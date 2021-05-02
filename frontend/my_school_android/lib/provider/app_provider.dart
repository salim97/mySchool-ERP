import 'package:flutter/material.dart';
import 'package:my_school_android/app/costants.dart';

// enum DisplayedPage { HOME, PRODUCTS, ORDERS, USERS, BRANDS, CATEGORIES }
// enum DisplayedPageForAdmin { Dashboard, Teachers, Students, Parents, Classes, Attendance }

class AppProvider with ChangeNotifier {
  Map sideMenu;
  String currentPage;

  Locale locale = Locale('fr', 'FR');
  // Locale locale = Locale('en', 'US');

  AppProvider.init() {
    sideMenu = Constants.menuStudent;
    notifyListeners();
  }


}
