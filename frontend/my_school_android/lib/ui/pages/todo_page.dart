import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.header(context, 'TO-DO'),
      backgroundColor: Colors.white,
      body: Container(
          child: Container(
              color: Colors.red[400],
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.progressWrench,
                    color: Colors.white,
                    size: 256,
                  ),
                  Text(
                    "This page is down for maintenance",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 38, ),
                  ),
                  Text(
                    "It will be back shortly",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ))),
    );
  }
}
