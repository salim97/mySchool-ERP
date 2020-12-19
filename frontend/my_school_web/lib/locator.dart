import 'package:common/services/teacher_service.dart';
import 'package:my_school_web/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:common/common.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<TeacherService>(() => FakeTeacherService());
}
