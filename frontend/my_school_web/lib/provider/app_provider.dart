import 'package:my_school_web/app/helpers/costants.dart';
import 'package:my_school_web/models/orders.dart';
import 'package:flutter/material.dart';

// enum DisplayedPage { HOME, PRODUCTS, ORDERS, USERS, BRANDS, CATEGORIES }
// enum DisplayedPageForAdmin { Dashboard, Teachers, Students, Parents, Classes, Attendance }

class AppProvider with ChangeNotifier {
  Map sideMenu;
  String currentPage;
  OrderModel _orderModel = null;
  double revenue = 0;

  AppProvider.init() {
    sideMenu = menuAdmin;
    _getRevenue();
    changeCurrentPage(sideMenu.keys.first);
  }

  changeCurrentPage(String newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  void _getRevenue() async {

  }
}
