import 'package:my_school_web/common/common.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'add_parent.view.model.dart';

class AddParentView extends StatefulWidget {
  @override
  _AddParentViewState createState() => _AddParentViewState();
}

class _AddParentViewState extends State<AddParentView> {
  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;
  onChildCreateNew(model) {
    model.onChildCreateNew();
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ViewModelBuilder<AddParentViewModel>.reactive(
      viewModelBuilder: () => AddParentViewModel(),
      onModelReady: (model) {
        final ParentModel parentModel = ModalRoute.of(context).settings.arguments;
        if (parentModel != null) {
          model.fillUI(parentModel);
          model.parentModel = parentModel;
          model.onChildRefresh();
        } else {
          var now = new DateTime.now();
          String random = now.millisecondsSinceEpoch.toString();
          model.phoneController.text = random;
          model.usernameController.text = random;
          model.emailAddressController.text = random + "@email.com";
          model.passwordController.text = "azerty2020";
          model.confirmPasswordController.text = "azerty2020";
        }
      },
      builder: (
        BuildContext context,
        AddParentViewModel model,
        Widget child,
      ) {
        List<DatatableHeader> headers = [
          DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
          DatatableHeader(text: "Roll No.", value: "Roll No.", show: true, sortable: true, textAlign: TextAlign.left),
          DatatableHeader(text: "Full Name", value: "Full Name", show: true, sortable: true, textAlign: TextAlign.center),
          DatatableHeader(text: "Email", value: "Email", show: true, sortable: true, textAlign: TextAlign.center),
          DatatableHeader(text: "Phone", value: "Phone", show: true, sortable: true, textAlign: TextAlign.center),
          DatatableHeader(
              flex: 2,
              text: "Action",
              value: "Action",
              show: true,
              sortable: false,
              sourceBuilder: (value, row) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () async {
                          await model.onChildView(value);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await model.onChildEdit(value);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await model.onChildDelete(value);
                        },
                      )
                    ],
                  ),
                );
              },
              textAlign: TextAlign.center),
        ];

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
                              userProfile(),
                              SizedBox(
                                width: 150,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Gender",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      addRadioButton(btnValue: 0, title: 'Male', onChanged: model.onGenderChanged),
                                      addRadioButton(btnValue: 1, title: 'Female', onChanged: model.onGenderChanged),
                                    ],
                                  ),
                                ],
                              ),
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
                                  "Children",
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              )
                            ],
                          ),
                          SingleChildScrollView(
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                            PageHeader(
                              text: appProvider.currentPage,
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(0),
                              child: Card(
                                elevation: 1,
                                shadowColor: Colors.black,
                                clipBehavior: Clip.none,
                                child: ResponsiveDatatable(
                                  title: Row(
                                    children: [
                                      RaisedButton.icon(
                                        onPressed: () {
                                          model.onChildRefresh();
                                        },
                                        icon: Icon(
                                          Icons.refresh,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "Refresh",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      RaisedButton.icon(
                                        onPressed: onChildCreateNew(model),
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "Create New",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue,
                                      )
                                    ],
                                  ),
                                  headers: headers,
                                  source: model.source,
                                  selecteds: model.selecteds,
                                  showSelect: model.showSelect,
                                  autoHeight: true,
                                  isLoading: model.isLoading,
                                ),
                              ),
                            ),
                          ]))
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
                              !model.editOnly
                                  ? Container()
                                  : userInputText(title: "Username", textEditingController: model.usernameController, mustFill: true),
                              !model.editOnly
                                  ? Container()
                                  : userInputText(
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
                              !model.editOnly
                                  ? Container()
                                  : userInputText(
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
                              !model.editOnly
                                  ? Container()
                                  : Padding(
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
                              // userInputDate(title: "Joining Date", textEditingController: model.joiningDateController),
                              // userInputDate(title: "Leaving Date", textEditingController: model.leavingDateController),
                              // userInputText(title: "Current Position", textEditingController: model.currentPositionController),
                              // Row(
                              //   children: [
                              //     Flexible(
                              //         child: userInputText(title: "Employee Code", textEditingController: model.employeeCodeController)),
                              //     Flexible(
                              //         child: userInputText(title: "Working Hours", textEditingController: model.workingHoursController)),
                              //   ],
                              // ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      color: Colors.green,
                                      onPressed: () async {
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
                                      onPressed: () {
                                        model.onBackClicked();
                                      },
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

  List gender = ["Male", "Female"];
  String select = "Male";
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

  Widget userProfile({String imagePath}) {
    double size = 128;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Profile Image"),
          GestureDetector(
            onTap: () {
              print("nikmok");
            },
            child: SizedBox(
              height: size,
              width: size,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset("assets/images/default_avtar.jpg"),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: FloatingActionButton(
                      mini: true,
                      child: Icon(Icons.edit),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
