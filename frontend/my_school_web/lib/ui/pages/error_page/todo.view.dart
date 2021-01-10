import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(0),
            constraints: BoxConstraints(
              maxHeight: 700,
            ),
            child: Card(
              elevation: 1,
              shadowColor: Colors.black,
              clipBehavior: Clip.none,
              color: Colors.red[400],
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
                    style: TextStyle(color: Colors.white, fontSize: 64),
                  ),
                  Text(
                    "It will be back shortly",
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ],
              ),
            )));
  }
}
