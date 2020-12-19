import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'add_teacher_view_model.dart';

class AddTeacherView extends StatefulWidget {
  @override
  _AddTeacherViewState createState() => _AddTeacherViewState();
}

class _AddTeacherViewState extends State<AddTeacherView> {
  bool _obscureText = true;
  List gender = ["Male", "Female", "Other"];
  String select = "Male";

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<AddTeacherViewModel>.reactive(
      viewModelBuilder: () => AddTeacherViewModel(),
      builder: (
        BuildContext context,
        AddTeacherViewModel model,
        Widget child,
      ) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Form(
              key: model.formKey,
              child: Column(
                // shrinkWrap: true,
                children: [
                  PageHeader(
                    text: appProvider.currentPage,
                  ),
                  Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      clipBehavior: Clip.none,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Personal Details",
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Gender"),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              addRadioButton(btnValue: 0, title: 'Male', onChanged: model.onGenderChanged),
                              addRadioButton(btnValue: 1, title: 'Female', onChanged: model.onGenderChanged),
                              addRadioButton(btnValue: 2, title: 'Others', onChanged: model.onGenderChanged),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child:
                                      userInputText(title: "First Name", textEditingController: model.firstNameController, mustFill: true)),
                              Flexible(child: userInputText(title: "Middle Name", textEditingController: model.middleNameController)),
                              Flexible(
                                  child:
                                      userInputText(title: "Last Name", textEditingController: model.lastNameController, mustFill: true)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: userInputDate(title: "Date of birth", textEditingController: model.dateOfBirthController)),
                              Flexible(
                                child:
                                    userInputText(title: "Phone", hintText: "0X XXXX XXXX", textEditingController: model.phoneController),
                              ),
                              Flexible(child: userInputText(title: "Qualification", textEditingController: model.qualificationController)),
                            ],
                          ),
                          Row(children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                                  color: Colors.grey,
                                  child: Divider(
                                    color: Colors.black,
                                    height: 2.0,
                                  )),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Address",
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: userInputText(
                                    title: "Street Address", textEditingController: model.streetAddressController, mustFill: true),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: userInputText(title: "City Name", textEditingController: model.cityNameController)),
                              Flexible(child: userInputText(title: "Country", textEditingController: model.countryController)),
                              Flexible(child: userInputText(title: "Pin Code", textEditingController: model.pinCodeController)),
                            ],
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            clipBehavior: Clip.none,
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Account Information",
                                      style: TextStyle(fontSize: 24.0),
                                    ),
                                  )
                                ],
                              ),
                              userInputText(
                                  title: "Email Address",
                                  textEditingController: model.emailAddressController,
                                  mustFill: true,
                                  onValidator: (value) {
                                    if (!value.contains("@")) {
                                      return "Please enter a valid email address";
                                    }
                                  }),
                              userInputText(title: "Username", textEditingController: model.usernameController, mustFill: true),
                              userInputText(
                                  title: "Password",
                                  textEditingController: model.passwordController,
                                  mustFill: true,
                                  obscureText: _obscureText,
                                  onValidator: (value) {
                                    if (value.length < 5) {
                                      return "Password must be at least 5 characters long.";
                                    }
                                    if (model.passwordController.text != value) {
                                      return "Please enter same password.";
                                    }
                                  }),
                              userInputText(
                                  title: "ConfirmPassword",
                                  textEditingController: model.confirmPasswordController,
                                  mustFill: true,
                                  obscureText: _obscureText,
                                  onValidator: (value) {
                                    if (value.length < 5) {
                                      return "Password must be at least 5 characters long.";
                                    }
                                    if (model.passwordController.text != value) {
                                      return "Please enter same password.";
                                    }
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Text(
                                    _obscureText ? "Show Password" : "Hide Password",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ])),
                      ),
                      Expanded(
                        child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            clipBehavior: Clip.none,
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "School details",
                                      style: TextStyle(fontSize: 24.0),
                                    ),
                                  )
                                ],
                              ),
                              userInputDate(title: "Joining Date", textEditingController: model.joiningDateController),
                              userInputDate(title: "Leaving Date", textEditingController: model.leavingDateController),
                              userInputText(title: "Current Position", textEditingController: model.currentPositionController),
                              Row(
                                children: [
                                  Flexible(
                                      child: userInputText(title: "Employee Code", textEditingController: model.employeeCodeController)),
                                  Flexible(
                                      child: userInputText(title: "Working Hours", textEditingController: model.workingHoursController)),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      color: Colors.green,
                                      onPressed: () {
                                        model.onSubmitClicked();
                                      },
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      color: Colors.black,
                                      onPressed: () {},
                                      child: Text(
                                        "Back",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ])),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget userInputText(
      {String title,
      String hintText,
      TextEditingController textEditingController,
      bool mustFill = false,
      Function(String) onValidator = null,
      bool obscureText = false}) {
    if (hintText == null) hintText = title;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Text(title),
                  mustFill
                      ? Text(
                          " *",
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              )),
          TextFormField(
            obscureText: obscureText,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
            ),
            validator: mustFill == true
                ? onValidator == null
                    ? (value) {
                        if (value.isEmpty) {
                          return "Please provide a " + title;
                        }
                      }
                    : onValidator
                : null,
          )
        ],
      ),
    );
  }

  Widget userInputDate({
    String title,
    String hintText,
    TextEditingController textEditingController,
    bool mustFill = false,
  }) {
    if (hintText == null) hintText = title;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Text(title),
                  mustFill
                      ? Text(
                          " *",
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              )),
          DateTimeField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
            ),
            format: DateFormat("yyyy-MM-dd"),
            onShowPicker: (context, currentValue) async {
              final pickedDate = await showDatePicker(
                  context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100));
              return pickedDate;
            },
          ),
        ],
      ),
    );
  }

  Row addRadioButton({int btnValue, String title, Function(dynamic) onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              // print(value);
              select = value;
            });
            onChanged(value);
          },
        ),
        Text(title)
      ],
    );
  }
}
