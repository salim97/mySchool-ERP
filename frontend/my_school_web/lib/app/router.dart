// flutter pub run build_runner clean
//  flutter pub get ; flutter pub run build_runner build --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';

import 'package:my_school_web/main.dart';
import 'package:my_school_web/ui/pages/WorkingHours/working_hours_view.dart';
import 'package:my_school_web/ui/pages/academics/classRoom/classRoom_view.dart';
import 'package:my_school_web/ui/pages/dashboard/dashboard_view.dart';
import 'package:my_school_web/ui/pages/home/home_view.dart';
import 'package:my_school_web/ui/pages/login/login_view.dart';
import 'package:my_school_web/ui/pages/parents/add_parent_view.dart';
import 'package:my_school_web/ui/pages/parents/parents_view.dart';
import 'package:my_school_web/ui/pages/parents/select_child_view.dart';
import 'package:my_school_web/ui/pages/splash/splash_view.dart';
import 'package:my_school_web/ui/pages/students/add_student_view.dart';
import 'package:my_school_web/ui/pages/students/students_view.dart';
import 'package:my_school_web/ui/pages/teachers/add_teacher_view.dart';
import 'package:my_school_web/ui/pages/teachers/teachers_view.dart';
import 'package:my_school_web/ui/pages/todo_page.dart';

// Defining routes and global transitions
@CustomAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: AppPagesController),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: TeachersView),
    MaterialRoute(page: AddTeacherView),
    MaterialRoute(page: StudentsView),
    MaterialRoute(page: AddStudentView),
    MaterialRoute(page: ParentsView),
    MaterialRoute(page: AddParentView),
    MaterialRoute(page: SelectStudentView),
    MaterialRoute(page: WorkingHoursView),
    MaterialRoute(page: ToDoPage),
    MaterialRoute(page: ClassRoomView),
  ],
  transitionsBuilder: TransitionsBuilders.zoomIn,
  durationInMilliseconds: 400,
)
class $Router {}

