import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';

import 'student_teacher_view_model.dart';

// ignore: must_be_immutable
class StudentTeacherView extends StatefulWidget {
  String id;

  StudentTeacherView({this.id});

  @override
  _StudentTeacherViewState createState() => _StudentTeacherViewState();
}

class _StudentTeacherViewState extends State<StudentTeacherView> with SingleTickerProviderStateMixin {
  List<TeacherModel> teachers = [
    TeacherModel(
      full_name: "teacher name 01",
      email_address: "email@email.com",
      phone: "05XX XX XX XX",
    ),
    TeacherModel(
      full_name: "teacher name 01",
      email_address: "email@email.com",
      phone: "06XX XX XX XX",
    ),
    TeacherModel(
      full_name: "teacher name 01",
      email_address: "email@email.com",
      phone: "07XX XX XX XX",
    ),
    TeacherModel(
      full_name: "teacher name 01",
      email_address: "email@email.com",
      phone: "05XX XX XX XX",
    ),
  ];

  int mId;
  int perm = -1;
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;



    return ViewModelBuilder<StudentTeacherViewModel>.reactive(
      viewModelBuilder: () => StudentTeacherViewModel(),
      builder: (
        BuildContext context,
        StudentTeacherViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBarWidget.header(context, 'Teacher'),
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Container(
                        transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Teacher Name',
                                  style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0, fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                              child: Text('Email',
                                  style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0, fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                              child: Text('Phone',
                                  style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0, fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    return StudentTeacherRowLayout(teachers[index], 1);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class StudentTeacherRowLayout extends StatelessWidget {
  TeacherModel teacher;
  int per;

  StudentTeacherRowLayout(this.teacher, this.per);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(teacher.full_name, style: Theme.of(context).textTheme.display1.copyWith(fontSize: 10.0)),
              ),
              Expanded(
                child: Text(teacher.email_address, style: Theme.of(context).textTheme.display1.copyWith(fontSize: 10.0)),
              ),
              Expanded(
                child:
                    Text(per == 1 ? teacher.phone : 'not available', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 10.0)),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [Colors.purple, Colors.deepPurple]),
          ),
        ),
      ],
    );
  }
}
