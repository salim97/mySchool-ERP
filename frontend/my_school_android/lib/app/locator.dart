// flutter pub get ; flutter pub run build_runner build --delete-conflicting-outputs

// import 'package:common/common.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_school_android/common/common.dart';
import 'package:my_school_android/services/PushNotificationService.dart';

import 'locator.iconfig.dart';


final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  // locator.registerLazySingleton(() => NavigationService());
  $initGetIt(locator);
  locator.registerLazySingleton(() => PushNotificationService());
  
  locator.registerLazySingleton<TeacherService>(() => TeacherServiceImpl());
  locator.registerLazySingleton<StudentService>(() => StudentServiceImpl());
  locator.registerLazySingleton<ParentService>(() => ParentServiceImpl());
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  // locator.registerLazySingleton<ClassRoomService>(() => ClassRoomServiceImpl());
  locator.registerLazySingleton<ClassRoomService>(() => ClassRoomServiceFake());
  locator.registerLazySingleton<GroupService>(() => GroupServiceImpl());
  locator.registerLazySingleton<SectionService>(() => SectionServiceImpl());
  locator.registerLazySingleton<SubjectService>(() => SubjectServiceImpl());
  locator.registerLazySingleton<TeacherSubjectService>(() => TeacherSubjectServiceImpl());
  // locator.registerLazySingleton<TimeTableService>(() => TimeTableServiceImpl());
  locator.registerLazySingleton<TimeTableService>(() => TimeTableServiceFake());
  locator.registerLazySingleton<WorkingHoursService>(() => WorkingHoursServiceImpl());
  locator.registerLazySingleton<NotificationService>(() => NotificationServiceImpl());
}
