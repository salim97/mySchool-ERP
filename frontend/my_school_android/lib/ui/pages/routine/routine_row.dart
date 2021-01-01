import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';

// ignore: must_be_immutable
class RoutineRow extends StatefulWidget {
  String title;
  int classCode;
  int sectionCode;
  String id;

  RoutineRow({this.title, this.classCode, this.sectionCode, this.id});

  @override
  _ClassRoutineModelState createState() => _ClassRoutineModelState(title, classCode, sectionCode);
}

class _ClassRoutineModelState extends State<RoutineRow> {
  String title;
  int classCode;
  int sectionCode;
  List<ClassRoutineModel> routine = [
    ClassRoutineModel(
      startTime: "08:00",
      endTime: "09:30",
      subject: "English",
      room: "102",
    ),
    ClassRoutineModel(
      startTime: "09:30",
      endTime: "11:00",
      subject: "General Math",
      room: "105",
    ),
    ClassRoutineModel(
      startTime: "11:00",
      endTime: "12:30",
      subject: "Science",
      room: "101",
    ),
    ClassRoutineModel(
      startTime: "12:30",
      endTime: "14:00",
      subject: "Biology",
      room: "108",
    ),
    ClassRoutineModel(
      startTime: "14:00",
      endTime: "15:30",
      subject: "Arts",
      room: "106",
    ),
  ];

  _ClassRoutineModelState(this.title, this.classCode, this.sectionCode);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(title, style: Theme.of(context).textTheme.title.copyWith(fontSize: 15.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('Time', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                ),
                Expanded(
                  child: Text('Subject', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                ),
                Expanded(
                  child: Text('Room', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: routine.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return RoutineRowDesign(
                routine.elementAt(index).startTime + ' - ' + routine.elementAt(index).endTime,
                routine.elementAt(index).subject,
                routine.elementAt(index).room,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 0.5,
              decoration: BoxDecoration(
                color: Color(0xFF415094),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class RoutineRowDesign extends StatelessWidget {
  String time;
  String subject;
  String room;

  RoutineRowDesign(this.time, this.subject, this.room);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(time, style: Theme.of(context).textTheme.display1),
          ),
          Expanded(
            child: Text(subject, style: Theme.of(context).textTheme.display1),
          ),
          Expanded(
            child: Text(room, style: Theme.of(context).textTheme.display1),
          ),
        ],
      ),
    );
  }
}
