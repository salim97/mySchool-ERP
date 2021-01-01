// flutter pub get ; flutter pub run build_runner build --delete-conflicting-outputs

import 'package:common/common.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_school_android/services/PushNotificationService.dart';

import 'locator.iconfig.dart';


final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  // locator.registerLazySingleton(() => NavigationService());
  $initGetIt(locator);
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton<TeacherService>(() => FakeTeacherService());
  locator.registerLazySingleton<StudentService>(() => FakeStudentService());
  locator.registerLazySingleton<WorkingHoursService>(() => FakeWorkingHoursService());
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
}
