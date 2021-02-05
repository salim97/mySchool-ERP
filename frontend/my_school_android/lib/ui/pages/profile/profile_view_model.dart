import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:my_school_android/app/costants.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  Map<String, String> userInfo = {
    "name": "name",
    "Group": null,
    "Section": null,
    "rollNo": null,
    "Date of Birth": "05/05/2015",
    "Religion": "05/05/2015",
    "Phone Number": "+213 6XX XXX XX",
    "Email address": "email@email.com",
    "Present address": "85/6, Address, DZ",
    "Father name": "Father Name",
    "Mother name": "Mother Name",
    "Blood group": "O(+ve)",
  };
  init() async {
    Response response = await _authService.me();
    if (response.statusCode != 200) return;

    if (_authService.userModel.role == "student") {
      StudentModel studentModel = StudentModel.fromJson(response.data["data"]["extra"]);
      final TimeTableService timeTableService = locator<TimeTableService>();
      await timeTableService.getAll();
      GroupModel groupModel = null;
      timeTableService.list.forEach((element1) {
        element1.groupid.children.forEach((element2) {
          if (groupModel == null) {
            if (element2.id == studentModel.id) groupModel = element1.groupid;
          }
        });
      });

      userInfo = {
        "name": studentModel.name,
        "rollNo": studentModel.rollNo,
        "Group": groupModel.name,
        "Section": groupModel.section.name,
        "date_of_birth": studentModel.date_of_birth,
        "phone": studentModel.phone,
        "email": studentModel.userAccount.email,
        "street_address": studentModel.street_address,
        "blood_group": studentModel.blood_group,
        "role": _authService.userModel.role,
      };
    }
    if (_authService.userModel.role == "parent") {
      ParentModel parentModel = ParentModel.fromJson(response.data["data"]["extra"]);
      userInfo = {
        "name": parentModel.name,
        "rollNo": null,
        "Group": null,
        "Section": null,
        "date_of_birth": parentModel.date_of_birth,
        "phone": parentModel.phone,
        "email": parentModel.userAccount.email,
        "role": _authService.userModel.role,
      };
    }
    if (_authService.userModel.role == "teacher") {
      TeacherModel teacherModel = TeacherModel.fromJson(response.data["data"]["extra"]);
      userInfo = {
        "name": teacherModel.name,
        "date_of_birth": teacherModel.date_of_birth,
        "phone": teacherModel.phone,
        "email": teacherModel.userAccount.email,
        "street_address": teacherModel.street_address,
        "blood_group": teacherModel.blood_group,
        "role": _authService.userModel.role,
      };
    }
    notifyListeners();
  }
}
