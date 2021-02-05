// flutter pub run build_runner clean
// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:my_school_android/ui/pages/attendance/attendance_view.dart';
import 'package:my_school_android/ui/pages/documents/documents_view.dart';
import 'package:my_school_android/ui/pages/examination/examination_view.dart';
import 'package:my_school_android/ui/pages/home/home_view.dart';
import 'package:my_school_android/ui/pages/homework/homework_view.dart';
import 'package:my_school_android/ui/pages/login/login_view.dart';
import 'package:my_school_android/ui/pages/notice/notice_view.dart';
import 'package:my_school_android/ui/pages/profile/profile_view.dart';
import 'package:my_school_android/ui/pages/routine/routine_view.dart';
import 'package:my_school_android/ui/pages/settings/settings_view.dart';
import 'package:my_school_android/ui/pages/splash/splash_view.dart';
import 'package:my_school_android/ui/pages/subjects/subject_screen_view.dart';
import 'package:my_school_android/ui/pages/teachers/student_teacher_view.dart';
import 'package:my_school_android/ui/pages/todo_page.dart';

@CustomAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: RoutineView),
    MaterialRoute(page: ToDoPage),
    // MaterialRoute(page: HomeWorkView),
    MaterialRoute(page: SubjectView),
    MaterialRoute(page: StudentTeacherView),
    MaterialRoute(page: AttendanceView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: DocumentsView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: NoticeView),
    MaterialRoute(page: ExaminationView),
  ],
  transitionsBuilder: TransitionsBuilders.zoomIn,
  durationInMilliseconds: 400,
)
class $Router {}

