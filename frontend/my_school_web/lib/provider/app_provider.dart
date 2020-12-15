import 'package:my_school_web/helpers/costants.dart';
import 'package:my_school_web/models/orders.dart';
import 'package:my_school_web/services/orders.dart';
import 'package:flutter/material.dart';

// enum DisplayedPage { HOME, PRODUCTS, ORDERS, USERS, BRANDS, CATEGORIES }
// enum DisplayedPageForAdmin { Dashboard, Teachers, Students, Parents, Classes, Attendance }

class AppProvider with ChangeNotifier {
  Map sideMenu;
  String currentPage;
  OrderServices _orderServices = OrderServices();
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
    await _orderServices.getAllOrders().then((orders) {
      for (OrderModel order in orders) {
        revenue = revenue + order.total;
        print("======= TOTAL REVENUE: ${revenue.toString()}");
        print("======= TOTAL REVENUE: ${revenue.toString()}");
        print("======= TOTAL REVENUE: ${revenue.toString()}");
      }
      notifyListeners();
    });
  }
}
