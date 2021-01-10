// flutter pub run build_runner clean
//  flutter pub get ; flutter pub run build_runner build --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';

import 'package:my_school_web/main.dart';
import 'package:my_school_web/ui/pages/WorkingHours/working_hours.view.dart';
import 'package:my_school_web/ui/pages/academics/classRoom/classRoom.view.dart';
import 'package:my_school_web/ui/pages/dashboard/dashboard.view.dart';
import 'package:my_school_web/ui/pages/home/home.view.dart';
import 'package:my_school_web/ui/pages/login/login.view.dart';
import 'package:my_school_web/ui/pages/parents/add_parent.view.dart';
import 'package:my_school_web/ui/pages/parents/parents.view.dart';
import 'package:my_school_web/ui/pages/parents/select_child.view.dart';
import 'package:my_school_web/ui/pages/splash/splash.view.dart';
import 'package:my_school_web/ui/pages/students/add_student.view.dart';
import 'package:my_school_web/ui/pages/students/students.view.dart';
import 'package:my_school_web/ui/pages/teachers/add_teacher.view.dart';
import 'package:my_school_web/ui/pages/teachers/teachers.view.dart';
import 'package:my_school_web/ui/pages/todo_page.view.dart';

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

