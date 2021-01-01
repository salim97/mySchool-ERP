import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';

import 'subject_screen_view_model.dart';

// ignore: must_be_immutable
class SubjectView extends StatefulWidget {
  String id;

  SubjectView({this.id});

  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  List<SubjectModel> subjects = [
    SubjectModel(
      name: "English",
      teacher_name: "teacher name 01",
      type: "Theory",
    ),
    SubjectModel(
      name: "Science",
      teacher_name: "teacher name 02",
      type: "Practical",
    ),
    SubjectModel(
      name: "General Maths",
      teacher_name: "teacher name 03",
      type: "Theory",
    ),
    SubjectModel(
      name: "Biology",
      teacher_name: "teacher name 04",
      type: "Practical",
    ),
    SubjectModel(
      name: "English",
      teacher_name: "teacher name 01",
      type: "Theory",
    ),
    SubjectModel(
      name: "Science",
      teacher_name: "teacher name 02",
      type: "Practical",
    ),
    SubjectModel(
      name: "General Maths",
      teacher_name: "teacher name 03",
      type: "Theory",
    ),
    SubjectModel(
      name: "Biology",
      teacher_name: "teacher name 04",
      type: "Practical",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<SubjectScreenViewModel>.reactive(
      viewModelBuilder: () => SubjectScreenViewModel(),
      builder: (
        BuildContext context,
        SubjectScreenViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBarWidget.header(context, 'Subjects'),
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Subject',
                            style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0, fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: Text('Teacher',
                            style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0, fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child:
                            Text('Type', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return SubjectRowLayout(subjects[index]);
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
class SubjectRowLayout extends StatelessWidget {
  SubjectModel subject;

  SubjectRowLayout(this.subject);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(subject.name, style: Theme.of(context).textTheme.display1),
              ),
              Expanded(
                child: Text(subject.teacher_name, style: Theme.of(context).textTheme.display1),
              ),
              Expanded(
                child: Text(subject.type, style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [Colors.purple, Colors.deepPurple]),
          ),
        ),
      ],
    );
  }
}
