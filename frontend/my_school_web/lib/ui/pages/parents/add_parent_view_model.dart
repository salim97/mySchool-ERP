
import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:my_school_web/setup_bottom_sheet_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddParentViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ParentService parentService = locator<ParentService>();
  final AuthService authService = locator<AuthService>();
  ParentModel parentModel = new ParentModel();
  get editOnly => this.parentModel.id == null ? true : false;

  bool isSearch = false;
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool showSelect = true;
  bool isLoading = false;

  //personal details
  String selectedGender = "Male";
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //address
  //account information
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  //school details

  fillUI(ParentModel studentModel) {
    this.parentModel.id = studentModel.id;
    if (studentModel.gender != null) selectedGender = studentModel.gender;
    dateOfBirthController.text = studentModel.date_of_birth;
    phoneController.text = studentModel.phone;
    // qualificationController.text = teacherModel.qualification;

    emailAddressController.text = studentModel.userAccount.email;
    usernameController.text = studentModel.userAccount.name;
    passwordController.text = studentModel.userAccount.password;
    confirmPasswordController.text = studentModel.userAccount.password;

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
    parentModel.gender = selectedGender.toLowerCase();
    parentModel.date_of_birth = dateOfBirthController.text;
    parentModel.phone = phoneController.text;
    // studentModel.qualification = qualificationController.text;

    parentModel.userAccount.email = emailAddressController.text;
    parentModel.userAccount.name = usernameController.text;
    parentModel.userAccount.password = passwordController.text;
    parentModel.userAccount.role = "parent";

    // if (formKey.currentState.validate()) {
    //   print("validated");
    // } else {
    //   print("Not validated");
    // }

    Response response;
    if (parentModel.id == null) {
      print("new");
      response = await authService.signup(UserModel(
        name: parentModel.userAccount.name,
        password: parentModel.userAccount.password,
        role: parentModel.userAccount.role,
        email: parentModel.userAccount.email,
      ));
      // log.i(response.data);
      // print(response.statusCode);

      parentModel.userAccount.id = response.data["data"]["user"]["_id"];
      response = await parentService.add(parentModel);
    } else {
      print("update");
      response = await authService.updateUser(parentModel.userAccount);
      print(response.data);
      print(response.statusCode);

      response = await parentService.update(parentModel);
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

  onChildRefresh() async {
    isLoading = true;
    notifyListeners();

    var children = parentModel.children;
    source.clear();

    children.forEach((element) {
      source.add({
        "ID": element.id,
        "Roll No.": "element.rollNo",
        "Full Name": element.userAccount.name,
        "Email": element.userAccount.email,
        "Phone": element.phone,
        "Action": element.id
      });
    });

    isLoading = false;
    notifyListeners();
  }

  onChildCreateNew() async {
    // var now = new DateTime.now();
    //       String random = now.millisecondsSinceEpoch.toString();
    // var tmp = StudentModel(
    //   id: random,
    //   phone: random,
    //   rollNo: random,
    // );
    // tmp.userAccount.email = random+"@email.com";
    // tmp.userAccount.name = random;
    // parentModel.children.add(tmp);

    parentService.parentModel = parentModel;
    await locator<NavigationService>().navigateTo(Routes.selectStudentView);
    await onChildRefresh();
  }

  onChildEdit(id) async {
    // ParentModel tm = listParentModel.firstWhere((element) => element.id == id);
    // await locator<NavigationService>().navigateTo(Routes.addStudentView, arguments: tm);
    // await onRefresh();
  }

  onChildView(id) async {
    StudentModel tm = parentModel.children.firstWhere((element) => element.id == id);
    String description = "";
    description += "Full Name :" + tm.userAccount.name + "\n";
    description += "Date of birth :" + "tm?.date_of_birth" + "\n";
    description += "Phone Number :" + tm.phone + "\n";
    description += "Position :" + "tm?.current_position" + "\n";
    description += "Address :" + "tm?.street_address" + "\n";
    description += "Joining Date :" + "tm?.joining_date" + "\n";
    description += "Working Hours :" + "tm?.working_hours" + "\n";
    description += "Gender :" + "tm?.gender" + "\n";
    description += "Email :" + tm.userAccount.email + "\n";
    description += "Blood Group :" + "tm?.blood_group" + "\n";
    description += "Qualification :" + " tm?.qualification" + "\n";
    description += "Leaving Date :" + "tm?.leaving_date" + "\n";
    description += "Employee Code :" + "tm.rollNo" + "\n";

    final _bottomSheetService = locator<BottomSheetService>();
    await _bottomSheetService.showBottomSheet(title: "INFO", description: description);
  }

  onChildDelete(id) async {
    final _bottomSheetService = locator<BottomSheetService>();
    var response = await _bottomSheetService.showBottomSheet(
        title: "Are you sure you want delete this record ?",
        description: "click on Yes to confirm suppresion of the record",
        confirmButtonTitle: "YES",
        cancelButtonTitle: "NO");
    if (response == null) return;
    if (response.confirmed) {
      parentModel.children.removeWhere((element) => element.id == id);
      await onChildRefresh();
    }
  }

  onGenderChanged(value) {
    selectedGender = value;
    notifyListeners();
  }
}
