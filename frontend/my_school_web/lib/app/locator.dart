//  flutter pub get ; flutter pub run build_runner build --delete-conflicting-outputs

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_school_web/common/common.dart';

import 'locator.config.dart';
// import 'locator.iconfig.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  // locator.registerLazySingleton(() => NavigationService());
  $initGetIt(locator);
  locator.registerLazySingleton<TeacherService>(() => TeacherServiceFake());
  locator.registerLazySingleton<StudentService>(() => StudentServiceFake());
  locator.registerLazySingleton<ParentService>(() => ParentServiceFake());
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  // locator.registerLazySingleton<WorkingHoursService>(() => FakeWorkingHoursService());
  locator.registerLazySingleton<ClassRoomService>(() => ClassRoomServiceFake());
  locator.registerLazySingleton<GroupService>(() => GroupServiceFake());
  locator.registerLazySingleton<SectionService>(() => SectionServiceFake());
  locator.registerLazySingleton<SubjectService>(() => SubjectServiceImpl());
  locator.registerLazySingleton<TeacherSubjectService>(() => TeacherSubjectServiceImpl());
  locator.registerLazySingleton<TimeTableService>(() => TimeTableServiceImpl());
  locator.registerLazySingleton<WorkingHoursService>(() => WorkingHoursServiceImpl());
  locator.registerLazySingleton<NotificationService>(() => NotificationServiceImpl());
}
