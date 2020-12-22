// flutter pub run build_runner clean
// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';

import 'package:my_school_web/main.dart';
import 'package:my_school_web/ui/pages/WorkingHours/working_hours_view.dart';
import 'package:my_school_web/ui/pages/dashboard/dashboard_view.dart';
import 'package:my_school_web/ui/pages/home/home_view.dart';
import 'package:my_school_web/ui/pages/login/login_view.dart';
import 'package:my_school_web/ui/pages/students/add_student_view.dart';
import 'package:my_school_web/ui/pages/students/students_view.dart';
import 'package:my_school_web/ui/pages/teachers/add_teacher_view.dart';
import 'package:my_school_web/ui/pages/teachers/teachers_view.dart';
import 'package:my_school_web/ui/pages/todo_page.dart';

// @MaterialAutoRouter()
// class $Routes {
//   @initial
//   DashboardView dashboardView;
//   TeachersView teachersView;
//   AddTeacherView addTeacherView;
//   HomeView homeView;
//   LoginView loginView;
//   AppPagesController appPagesController;
// }

// Defining routes and global transitions
@CustomAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LoginView),
    MaterialRoute(page: AppPagesController),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: TeachersView),
    MaterialRoute(page: AddTeacherView),
    MaterialRoute(page: StudentsView),
    MaterialRoute(page: AddStudentView),
    MaterialRoute(page: WorkingHoursView),
    MaterialRoute(page: ToDoPage),
  ],
  transitionsBuilder: TransitionsBuilders.zoomIn,
  durationInMilliseconds: 400,
)
class $Router {}

// Route<dynamic> generateRoute(RouteSettings settings) {
//   print('generateRoute: ${settings.name}');
//   switch (settings.name) {
//     case "Dashboard":
//       return _getPageRoute(DashboardView());
//     case "Teachers":
//       return _getPageRoute(TeachersView());
//     case "AddTeacherView":
//       return _getPageRoute(AddTeacherView());
//     case "LoginRoute":
//       return _getPageRoute(LoginView());
//     case "LayoutRoute":
//       return _getPageRoute(HomeView());
//     case "PageControllerRoute":
//       return _getPageRoute(AppPagesController());
//   }
// }

// PageRoute _getPageRoute(Widget child) {
//   return MaterialPageRoute(
//     builder: (context) => child,
//   );
// }
