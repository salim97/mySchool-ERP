import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddStudentViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StudentService studentService = locator<StudentService>();
  final AuthService authService = locator<AuthService>();
  StudentModel studentModel = new StudentModel();
  get editOnly => this.studentModel.id == null ? true : false;
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

  fillUI(StudentModel studentModel) {
    this.studentModel.id = studentModel.id;
    if (studentModel.gender != null) selectedGender = studentModel.gender;
    dateOfBirthController.text = studentModel.date_of_birth;
    phoneController.text = studentModel.phone;
    // qualificationController.text = teacherModel.qualification;

    streetAddressController.text = studentModel.street_address;
    cityNameController.text = studentModel.city_name;
    countryController.text = studentModel.country;
    pinCodeController.text = studentModel.pin_code;

    emailAddressController.text = studentModel.userAccount.email;
    usernameController.text = studentModel.userAccount.name;
    passwordController.text = studentModel.userAccount.password;
    confirmPasswordController.text = studentModel.userAccount.password;

    joiningDateController.text = studentModel.joining_date;
    leavingDateController.text = studentModel.leaving_date;
    currentPositionController.text = studentModel.current_position;
    employeeCodeController.text = studentModel.rollNo;
    workingHoursController.text = studentModel.working_hours;
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
    studentModel.gender = selectedGender.toLowerCase();
    studentModel.date_of_birth = dateOfBirthController.text;
    studentModel.phone = phoneController.text;
    // studentModel.qualification = qualificationController.text;

    studentModel.street_address = streetAddressController.text;
    studentModel.city_name = cityNameController.text;
    studentModel.country = countryController.text;
    studentModel.pin_code = pinCodeController.text;

    studentModel.userAccount.email = emailAddressController.text;
    studentModel.userAccount.name = usernameController.text;
    studentModel.userAccount.password = passwordController.text;
    studentModel.userAccount.role = "student";

    studentModel.joining_date = joiningDateController.text;
    studentModel.leaving_date = leavingDateController.text;
    studentModel.current_position = currentPositionController.text;
    studentModel.rollNo = employeeCodeController.text;
    studentModel.working_hours = workingHoursController.text;

    // if (formKey.currentState.validate()) {
    //   print("validated");
    // } else {
    //   print("Not validated");
    // }

    Response response;
    if (studentModel.id == null) {
      print("new");
      response = await authService.signup(UserModel(
        name: studentModel.userAccount.name,
        password: studentModel.userAccount.password,
        role: studentModel.userAccount.role,
        email: studentModel.userAccount.email,
      ));
      // log.i(response.data);
      // print(response.statusCode);

      studentModel.userAccount.id = response.data["data"]["user"]["_id"];
      response = await studentService.add(studentModel);
    } else {
      print("update");
      response = await authService.updateUser(studentModel.userAccount);
      print(response.data);
      print(response.statusCode);

      response = await studentService.update(studentModel);
      // print(response.data);
      // print(response.statusCode);
    }

    if (response.statusCode == 201 || response.statusCode == 200) {
      locator<NavigationService>().back();
    } else {
      // log.i(response.data);
      // print(response.statusCode);
    }
    //locator<NavigationService>().navigateTo(Routes.addTeacherView);
  }

  onGenderChanged(value) {
    selectedGender = value;
    notifyListeners();
  }
}
