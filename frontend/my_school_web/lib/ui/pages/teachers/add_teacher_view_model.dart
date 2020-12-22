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

  onBackClicked() async {
    //locator<NavigationService>().navigateTo(Routes.addTeacherView);
    // final DialogService _dialogService = locator<DialogService>();
    // DialogResponse dr = await _dialogService.showConfirmationDialog(
    //   title: 'The Confirmation Dialog',
    //   description: 'Do you want to update Confiramtion state in the UI?',
    //   confirmationTitle: 'Yes',
    //   cancelTitle: 'No',
    // );
    final _bottomSheetService = locator<BottomSheetService>();
    var response = await _bottomSheetService.showBottomSheet(title: "zab el kbir", description: "zebi vrai kbir");
    print(response?.confirmed);
    // print(dr);
    // await _dialogService.showCustomDialog(
    //     title: 'This is a custom UI with Text as main button',
    //     description: 'Sheck out the builder in the dialog_ui_register.dart file',
    //     mainButtonTitle: 'Ok',
    //     showIconInMainButton: false,
    //     barrierDismissible: true);
  }

  onSubmitClicked() {
    TeacherModel teacherModel = new TeacherModel();
    teacherModel.gender = selectedGender;
    teacherModel.first_name = firstNameController.text;
    teacherModel.middle_name = middleNameController.text;
    teacherModel.last_name = lastNameController.text;
    teacherModel.date_of_birth = dateOfBirthController.text;
    teacherModel.phone = phoneController.text;
    teacherModel.qualification = qualificationController.text;

    teacherModel.street_address = streetAddressController.text;
    teacherModel.city_name = cityNameController.text;
    teacherModel.country = countryController.text;
    teacherModel.pin_code = pinCodeController.text;

    teacherModel.email_address = emailAddressController.text;
    teacherModel.username = usernameController.text;
    teacherModel.password = passwordController.text;

    teacherModel.joining_date = joiningDateController.text;
    teacherModel.leaving_date = leavingDateController.text;
    teacherModel.current_position = currentPositionController.text;
    teacherModel.employee_code = employeeCodeController.text;
    teacherModel.working_hours = workingHoursController.text;

    Logger log = Logger();
    log.d(teacherModel.toJson());
    teacherService.add(teacherModel);
    if (formKey.currentState.validate()) {
      print("validated");
    } else {
      print("Not validated");
    }
    locator<NavigationService>().navigateTo(Routes.addTeacherView);
  }

  onGenderChanged(value) {
    selectedGender = value;
    notifyListeners();
  }
}
