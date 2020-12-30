import 'package:flutter/material.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:stacked/stacked.dart';

import 'profile_view_model.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isPersonal = false;
  bool isParents = false;
  bool isTransport = false;
  bool isOthers = false;
  String section = 'personal';
  String _email;
  String _password;
  String id;
  String image;
  Map<String, String> userInfo = {
    "Date of Birth": "05/05/2015",
    "Religion": "05/05/2015",
    "Phone Number": "+213 6XX XXX XX",
    "Email address": "email@email.com",
    "Present address": "85/6, Address, DZ",
    "Father name": "Father Name",
    "Mother name": "Mother Name",
    "Blood group": "O(+ve)",
  };

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (
        BuildContext context,
        ProfileViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBarWidget.header(context, 'Profile'),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 60.0,
                        height: 60.0,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundImage: AssetImage("assets/images/unknown_profile.png"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      getProfileHeader(fullName: "Full Name", classNumber: "5", sectionNumber: "A", rollNumber: "123456", admNumber: "89754321"),
                    ],
                  ),
                ),
              ),
              Container(
                height: 23.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPersonal = true;
                              isParents = false;
                              isTransport = false;
                              isOthers = false;

                              section = 'personal';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Personal',
                                style: Theme.of(context).textTheme.display1.copyWith(
                                      color: Color(0xFF415094),
                                    ),
                              ),
                              Container(
                                height: 2.0,
                                decoration: BoxDecoration(
                                  color: isPersonal ? Colors.deepPurpleAccent : Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isParents = true;
                              isPersonal = false;
                              isTransport = false;
                              isOthers = false;

                              section = 'parents';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Parents',
                                style: Theme.of(context).textTheme.display1.copyWith(
                                      color: Color(0xFF415094),
                                    ),
                              ),
                              Container(
                                height: 2.0,
                                decoration: BoxDecoration(
                                  color: isParents ? Colors.deepPurpleAccent : Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isTransport = true;
                              isParents = false;
                              isPersonal = false;
                              isOthers = false;

                              section = 'transport';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Transport',
                                style: Theme.of(context).textTheme.display1.copyWith(
                                      color: Color(0xFF415094),
                                    ),
                              ),
                              Container(
                                height: 2.0,
                                decoration: BoxDecoration(
                                  color: isTransport ? Colors.deepPurpleAccent : Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isTransport = false;
                              isParents = false;
                              isPersonal = false;
                              isOthers = true;

                              section = 'others';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Others',
                                style: Theme.of(context).textTheme.display1.copyWith(
                                      color: Color(0xFF415094),
                                    ),
                              ),
                              Container(
                                height: 2.0,
                                decoration: BoxDecoration(
                                  color: isOthers ? Colors.deepPurpleAccent : Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 15.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xfff3e5f5).withOpacity(0.5), Colors.white]),
                ),
              ),
              Expanded(
                child: getProfileList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getProfileList() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Container(
        child: ListView.builder(
          itemCount: userInfo.keys.length,
          itemBuilder: (BuildContext context, int index) {
            return ProfileRowList(userInfo.keys.elementAt(index), userInfo.values.elementAt(index));
          },
        ),
      ),
    );
  }

  Widget getProfileHeader({ fullName,  classNumber,  sectionNumber,  rollNumber, admNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(fullName, style: Theme.of(context).textTheme.headline),
        Text(
          'Class : ' + classNumber + ' | Section : ' +sectionNumber,
          style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFF727FC8)),
        ),
        Text(
          'Roll No: ' + rollNumber + ' | Adm No: ' + admNumber,
          style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFF727FC8)),
        ),
      ],
    );
  }


}


// ignore: must_be_immutable
class ProfileRowList extends StatelessWidget {

  String _key;
  String _value;

  ProfileRowList(this._key,this._value);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _key,
                    style: Theme.of(context).textTheme.display1,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 0.5,
                    decoration: BoxDecoration(
                      color: Color(0xFF415094),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _value == null ? 'NA':_value,
                    style: Theme.of(context).textTheme.display1,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 0.5,
                    decoration: BoxDecoration(
                      color: Color(0xFF415094),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
