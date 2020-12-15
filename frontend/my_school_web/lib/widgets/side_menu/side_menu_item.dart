import 'package:my_school_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SideMenuItemDesktop extends StatelessWidget {
  final bool active;
  final String text;
  final IconData icon;
  final Function onTap;

  const SideMenuItemDesktop({Key key, this.active, this.text, this.icon, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: active ? Colors.green.withOpacity(.3) : null,
      leading: Icon(icon, color: Colors.black),
      title: CustomText(
        text: text,
        color: Colors.black,
        size: 18, //active ? 23 : 18,
        weight: active ? FontWeight.bold : FontWeight.w300,
      ),
    );
  }
}
