import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:stacked/stacked.dart';

class RoutineViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final TimeTableService timeTableService = locator<TimeTableService>();
  TimeTableModel currentModel = null;
  List<String> days = List<String>();
  init() async {
    Response response = await _authService.me();
    if (response.statusCode != 200) return;

    if (_authService.userModel.role == "student") {
      StudentModel studentModel = StudentModel.fromJson(response.data["data"]["extra"]);

      await timeTableService.getAll();

      timeTableService.list.forEach((element1) {
        element1.groupid.children.forEach((element2) {
          if (currentModel == null) {
            if (element2.id == studentModel.id) currentModel = element1;
          }
        });
      });

      days.clear();

      currentModel.children.forEach((element2) {
        if (!days.contains(element2.day)) days.add(element2.day);
      });

      print("_authService.logger.d(currentModel)");
      print(days);
      _authService.logger.d(currentModel.toJson());
    }
    notifyListeners();
  }
}
