import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:my_school_android/common/common.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:my_school_android/ui/widgets/MyUtils.dart';
import 'package:stacked/stacked.dart';

import 'attendance_view_model.dart';

class AttendanceView extends StatefulWidget {
  @override
  _AttendanceViewState createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  List<AttendanceModel> attendances = [
    AttendanceModel(
      date: "2020-12-214",
      type: "P",
    ),
    AttendanceModel(
      date: "2020-12-215",
      type: "P",
    ),
    AttendanceModel(
      date: "2020-12-213",
      type: "A",
    ),
    AttendanceModel(
      date: "2020-12-212",
      type: "H",
    ),
  ];

  @override
  Widget build(BuildContext context) {
 
    return ViewModelBuilder<AttendanceViewModel>.reactive(
      viewModelBuilder: () => AttendanceViewModel(),
      builder: (
        BuildContext context,
        AttendanceViewModel model,
        Widget child,
      ) {
        var _currentDate;
        var _markedDateMap;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarWidget.header(context, 'Attendance'),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: CalendarCarousel<Event>(
                    onDayPressed: (DateTime date, List<Event> events) {
                      this.setState(() => _currentDate = date);
                    },
                    onCalendarChanged: (DateTime date) {
                      // setState(() {
                      //   attendances = getAllStudentAttendance(id, date.month, date.year);
                      // });
                    },
                    weekendTextStyle: Theme.of(context).textTheme.title,
                    thisMonthDayBorderColor: Colors.grey,
                    daysTextStyle: Theme.of(context).textTheme.display1,

//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
                    showOnlyCurrentMonthDate: false,
                    headerTextStyle: Theme.of(context).textTheme.title.copyWith(fontSize: 15.0),
                    weekdayTextStyle: Theme.of(context).textTheme.display1.copyWith(fontSize: 15.0, fontWeight: FontWeight.w500),
                    customDayBuilder: (
                      /// you can provide your own build function to make custom day containers
                      bool isSelectable,
                      int index,
                      bool isSelectedDay,
                      bool isToday,
                      bool isPrevMonthDay,
                      TextStyle textStyle,
                      bool isNextMonthDay,
                      bool isThisMonthDay,
                      DateTime day,
                    ) {
                      /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                      /// This way you can build custom containers for specific days only, leaving rest as default.

//                  if(isThisMonthDay){
//                    Utils.showToast(day.year.toString()+day.month.toString());
//
//                    attendances = getAllStudentAttendance(id, day.month, day.year);
//
//                  }

                      // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                      String status = getAttendanceStatus(day.day, attendances);

                      return Center(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(day.day.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(color: isToday == true ? Colors.white : Color(0xFF727FC8))),
                              SizedBox(
                                width: 2.0,
                              ),
                              Container(
                                width: 5.0,
                                height: 5.0,
                                decoration: BoxDecoration(
                                  color: getStatusColor(status),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    weekFormat: false,
                    markedDatesMap: _markedDateMap,
                    height: MediaQuery.of(context).size.height / 2,
                    selectedDateTime: _currentDate,
                    daysHaveCircularBorder: true,

                    /// null for not rendering any border, true for circular border, false for rectangular border
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView(
                    children: <Widget>[
                      bottomDesign('Present', 'P', Colors.green),
                      bottomDesign('Absent', 'A', Colors.red),
                      bottomDesign('Late', 'L', Colors.yellow),
                      bottomDesign('Halfday', 'H', Colors.purpleAccent),
                      bottomDesign('Holiday', 'F', Colors.deepPurpleAccent),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bottomDesign(String title, String titleVal, Color color) {
    return Center(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            height: 30.0,
            width: 60.0,
            decoration: BoxDecoration(
              color: color,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: Text(
            title,
            style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black45, fontWeight: FontWeight.w500),
          )),
          Text(getStatusCount(titleVal, attendances), style: Theme.of(context).textTheme.headline),
        ],
      ),
    );
  }

  String getAttendanceStatus(int date, List<AttendanceModel> attendances) {
    return getStatus(0, attendances.length - 1, attendances, date);
  }

  String getStatus(int i, int j, List<AttendanceModel> attendances, int date) {
    String status;
    for (int a = i; a <= j; a++) {
      if (a < 10) {
        if (MyUtils.getDay(attendances[a].date).substring(1) == date.toString()) {
          status = attendances[a].type;
          break;
        }
      } else {
        if (MyUtils.getDay(attendances[a].date) == date.toString()) {
          status = attendances[a].type;
          break;
        }
      }
    }
    return status;
  }

  getStatusColor(String status) {
    switch (status) {
      case 'P':
        return Colors.green;
        break;
      case 'A':
        return Colors.red;
        break;
      case 'L':
        return Colors.yellow;
        break;
      case 'H':
        return Colors.purpleAccent;
        break;
      case 'F':
        return Colors.deepPurple;
        break;
      default:
        return Colors.black12;
        break;
    }
  }

  String getStatusCount(String titleVal, List<AttendanceModel> attendances) {
    int count = 0;
    for (int i = 0; i < attendances.length; i++) {
      if (attendances[i].type == titleVal) {
        count = count + 1;
      }
    }
    //debugPrint('count $count');
    return '$count days';
  }
}
