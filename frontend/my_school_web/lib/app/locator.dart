// flutter pub run build_runner build

import 'package:my_school_web/common/common.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_school_web/common/common.dart';

import 'locator.iconfig.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  // locator.registerLazySingleton(() => NavigationService());
  $initGetIt(locator);
  locator.registerLazySingleton<TeacherService>(() => TeacherServiceImpl());
  locator.registerLazySingleton<StudentService>(() => StudentServiceImpl());
  locator.registerLazySingleton<ParentService>(() => ParentServiceImpl());
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  locator.registerLazySingleton<WorkingHoursService>(() => FakeWorkingHoursService());
}
