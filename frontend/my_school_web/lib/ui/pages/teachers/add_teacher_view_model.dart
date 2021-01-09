import 'package:dio/dio.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTeacherViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TeacherService teacherService = locator<TeacherService>();
  final AuthService authService = locator<AuthService>();
  TeacherModel teacherModel = new TeacherModel();
  get editOnly => this.teacherModel.id == null ? true : false;
  //personal details
  String selectedGender = "Male";
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  //address
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  //account information
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  //school details
  TextEditingController joiningDateController = TextEditingController();
  TextEditingController leavingDateController = TextEditingController();
  TextEditingController currentPositionController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();
  TextEditingController workingHoursController = TextEditingController();

  fillUI(TeacherModel teacherModel) {
    this.teacherModel.id = teacherModel.id;
    if (teacherModel.gender != null) selectedGender = teacherModel.gender;
    // firstNameController.text = teacherModel.first_name;
    // middleNameController.text = teacherModel.middle_name;
    // lastNameController.text = teacherModel.last_name;
    dateOfBirthController.text = teacherModel.date_of_birth;
    phoneController.text = teacherModel.phone;
    qualificationController.text = teacherModel.qualification;

    streetAddressController.text = teacherModel.street_address;
    cityNameController.text = teacherModel.city_name;
    countryController.text = teacherModel.country;
    pinCodeController.text = teacherModel.pin_code;

    emailAddressController.text = teacherModel.userAccount.email;
    usernameController.text = teacherModel.userAccount.name;

    joiningDateController.text = teacherModel.joining_date;
    leavingDateController.text = teacherModel.leaving_date;
    currentPositionController.text = teacherModel.current_position;
    employeeCodeController.text = teacherModel.employee_code;
    workingHoursController.text = teacherModel.working_hours;
    notifyListeners();
  }

  onBackClicked() async {
    // locator<NavigationService>().navigateTo(Routes.addTeacherView);
    locator<NavigationService>().back();

    // final _bottomSheetService = locator<BottomSheetService>();
    // var response = await _bottomSheetService.showBottomSheet(title: "zab el kbir", description: "zebi vrai kbir");
    // print(response?.confirmed);
  }

  onSubmitClicked() async {
    teacherModel.gender = selectedGender.toLowerCase();
    teacherModel.date_of_birth = dateOfBirthController.text;
    teacherModel.phone = phoneController.text;
    teacherModel.qualification = qualificationController.text;

    teacherModel.street_address = streetAddressController.text;
    teacherModel.city_name = cityNameController.text;
    teacherModel.country = countryController.text;
    teacherModel.pin_code = pinCodeController.text;

    teacherModel.userAccount.email = emailAddressController.text;
    teacherModel.userAccount.name = usernameController.text;
    teacherModel.userAccount.password = passwordController.text;
    teacherModel.userAccount.role = "teacher";

    teacherModel.joining_date = joiningDateController.text;
    teacherModel.leaving_date = leavingDateController.text;
    teacherModel.current_position = currentPositionController.text;
    teacherModel.employee_code = employeeCodeController.text;
    teacherModel.working_hours = workingHoursController.text;

    // if (formKey.currentState.validate()) {
    //   print("validated");
    // } else {
    //   print("Not validated");
    // }
    Response response;
    if (teacherModel.id == null) {
      print("new");
      response = await authService.signup(UserModel(
        name: teacherModel.userAccount.name,
        password: teacherModel.userAccount.password,
        role: teacherModel.userAccount.role,
        email: teacherModel.userAccount.email,
      ));
      // log.i(response.data);
      // print(response.statusCode);

      teacherModel.userAccount.id = response.data["data"]["user"]["_id"];
      response = await teacherService.add(teacherModel);
    } else {
      print("update");
      response = await authService.updateUser(teacherModel.userAccount);
      print(response.data);
      print(response.statusCode);

      response = await teacherService.update(teacherModel);
      // print(response.data);
      // print(response.statusCode);
    }
    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      locator<NavigationService>().back();
    } else {
      // log.i(response.data);
      // print(response.statusCode);
    }
  }

  onGenderChanged(value) {
    selectedGender = value;
    notifyListeners();
  }
}
