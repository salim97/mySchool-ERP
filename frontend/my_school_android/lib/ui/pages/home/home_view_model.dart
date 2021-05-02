import 'package:common/common.dart';
import 'package:my_school_android/app/costants.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:my_school_android/services/PushNotificationService.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
  final AuthService _authService = null; // locator<AuthService>();
  final TimeTableService timeTableService = new TimeTableServiceFake();
  Map menu = Constants.menuStudent;
  Future handleStartUpLogic() async {
    // await _pushNotificationService.initialise();
    // String token = await _pushNotificationService.fcm.getToken();
    // print("token");
    // print(token);
    // ...
    if (_authService.userModel.role == "student") {
      menu = Constants.menuStudent;
      // locator<StudentService>().getAll();
    }
    if (_authService.userModel.role == "parent") {
      menu = Constants.menuParent;
      // locator<ParentService>().getAll();
    }
    if (_authService.userModel.role == "teacher") {
      menu = Constants.menuTeacher;
      // locator<TeacherService>().getAll();
    }
    if (_authService.userModel.role == "admin") {
      menu = Constants.menuAdmin;
    }
    timeTableService.getAll();
  }
}
