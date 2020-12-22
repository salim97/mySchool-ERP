// flutter pub run build_runner build

import 'package:common/common.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.iconfig.dart';


final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  // locator.registerLazySingleton(() => NavigationService());
  $initGetIt(locator);
  locator.registerLazySingleton<TeacherService>(() => FakeTeacherService());
  locator.registerLazySingleton<StudentService>(() => FakeStudentService());
  locator.registerLazySingleton<WorkingHoursService>(() => FakeWorkingHoursService());
}
