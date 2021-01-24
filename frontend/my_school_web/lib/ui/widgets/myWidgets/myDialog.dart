import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class MyDialogs {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key, String title, String body, VoidCallback onCancel) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(key: key, backgroundColor: Colors.white, children: <Widget>[
                Center(
                  child: Column(children: [
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        body,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        onCancel();
                      },
                      child: Text("Annuler",
                          style: TextStyle(
                            color: Colors.green,
                          )),
                    )
                  ]),
                )
              ]));
        });
  }

  static askuserYESNO(BuildContext context, String title, String body) async {
    // flutter defined function
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("oui"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child: new Text("no"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  static timeTableAdd({
    BuildContext context,
    List<String> subjectList,
    List<String> teacherList,
    List<String> roomList,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        String subject, teacher, room;
        print(subjectList);
        return AlertDialog(
          title: new Text("Create Class Routine"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownSearch<String>(
                items: subjectList,
                maxHeight: 300,
                // onFind: (String filter) {
                //   print("onFind");
                //   print(subjectList.where((element) => element.contains(filter)).toList());
                //   var a =  Future<List<String>>.value(subjectList.where((element) => element.contains(filter)).toList());
                //   print(a);
                //   return a;
                // },
                label: "Select Subject*",
                onChanged: (item) => subject = item,
                showSearchBox: true,
              ),
              SizedBox(
                height: 20,
              ),
              DropdownSearch<String>(
                items: teacherList,
                maxHeight: 300,
                // onFind: (String filter) {
                //   return Future<List<String>>.value(teacherList.where((element) => element.contains(filter)).toList());
                // },
                label: "Select Teacher*",
                onChanged: (item) => teacher = item,
                showSearchBox: true,
              ),
              SizedBox(
                height: 20,
              ),
              DropdownSearch<String>(
                items: roomList,
                maxHeight: 300,
                // onFind: (String filter) {
                //   return Future<List<String>>.value(roomList.where((element) => element.contains(filter)).toList());
                // },
                label: "Select Room*",
                onChanged: print,
                showSearchBox: true,
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Save Information"),
              onPressed: () {
                print(subject);
                print(teacher);
                print(room);
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  
  }

  static showMSGtoUSER(BuildContext context, String msg) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
