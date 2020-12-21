import 'package:my_school_web/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SideMenuItemWidthSubItemDesktop extends StatelessWidget {
  final bool active;
  final String text;
  final IconData icon;
  final List<Widget> children;

  const SideMenuItemWidthSubItemDesktop({Key key, this.active, this.text, this.icon, this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new ExpansionTile(
            leading: Icon(icon, color: Colors.black),
            // backgroundColor: active ? Colors.green.withOpacity(.3) : null,
            // title: CustomText(
            //   text: text,
            //   color: Colors.white,
            //   size: active ? 23 : 18,
            //   weight: active ? FontWeight.bold : FontWeight.w300,
            // ),
            title: Text(text, style: TextStyle(color: Colors.black),),
            children: children),
      ],
    );
  }
}
