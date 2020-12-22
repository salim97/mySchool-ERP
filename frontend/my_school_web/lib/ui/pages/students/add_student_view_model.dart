import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddStudentViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StudentService studentService = locator<StudentService>();
  final StudentModel studentModel = new StudentModel();
  //personal details
  String selectedGender = "Male";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
    if(studentModel.gender != null)
    selectedGender = studentModel.gender ;
    firstNameController.text = studentModel.first_name;
    middleNameController.text = studentModel.middle_name;
    lastNameController.text = studentModel.last_name;
    dateOfBirthController.text = studentModel.date_of_birth;
    phoneController.text = studentModel.phone;
    // qualificationController.text = teacherModel.qualification;

    streetAddressController.text = studentModel.street_address;
    cityNameController.text = studentModel.city_name;
    countryController.text = studentModel.country;
    pinCodeController.text = studentModel.pin_code;

    emailAddressController.text = studentModel.email_address;
    usernameController.text = studentModel.username;
    passwordController.text = studentModel.password;
    confirmPasswordController.text = studentModel.password;

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

  onSubmitClicked() {
    studentModel.gender = selectedGender;
    studentModel.first_name = firstNameController.text;
    studentModel.middle_name = middleNameController.text;
    studentModel.last_name = lastNameController.text;
    studentModel.date_of_birth = dateOfBirthController.text;
    studentModel.phone = phoneController.text;
    // studentModel.qualification = qualificationController.text;

    studentModel.street_address = streetAddressController.text;
    studentModel.city_name = cityNameController.text;
    studentModel.country = countryController.text;
    studentModel.pin_code = pinCodeController.text;

    studentModel.email_address = emailAddressController.text;
    studentModel.username = usernameController.text;
    studentModel.password = passwordController.text;

    studentModel.joining_date = joiningDateController.text;
    studentModel.leaving_date = leavingDateController.text;
    studentModel.current_position = currentPositionController.text;
    studentModel.rollNo = employeeCodeController.text;
    studentModel.working_hours = workingHoursController.text;

    Logger log = Logger();
    log.d(studentModel.toJson());
    studentService.add(studentModel);
    if (formKey.currentState.validate()) {
      print("validated");
    } else {
      print("Not validated");
    }
    // locator<NavigationService>().navigateTo(Routes.addTeacherView);
    locator<NavigationService>().back();
  }

  onGenderChanged(value) {
    selectedGender = value;
    notifyListeners();
  }
}
