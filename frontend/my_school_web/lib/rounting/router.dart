import 'package:my_school_web/main.dart';
import 'package:my_school_web/pages/dashboard/dashboard_view.dart';
import 'package:my_school_web/pages/home/home_view.dart';
import 'package:my_school_web/pages/login/login_view.dart';
import 'package:my_school_web/pages/teachers/add_teacher_view.dart';
import 'package:my_school_web/pages/teachers/teachers_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case "Dashboard":
      return _getPageRoute(DashboardView());
    case "Teachers":
      return _getPageRoute(TeachersView());
    case "AddTeacherView":
      return _getPageRoute(AddTeacherView());
    // case ProductsRoute:
    //   return _getPageRoute(ProductsPage());
    // case OrdersRoute:
    //   return _getPageRoute(OrdersPage());
    case "LoginRoute":
      return _getPageRoute(LoginView());
    // case RegistrationRoute:
    //   return _getPageRoute(RegistrationPage());
    case "LayoutRoute":
      return _getPageRoute(HomeView());
    // case CategoriesRoute:
    //   return _getPageRoute(CategoriesPage());
    // case BrandsRoute:
    //   return _getPageRoute(BrandsPage());
    case "PageControllerRoute":
      return _getPageRoute(AppPagesController());
    //default:
    //  return _getPageRoute(LoginPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
