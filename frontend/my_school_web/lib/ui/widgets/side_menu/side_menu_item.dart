import 'package:my_school_web/ui/widgets/custom_text.dart';
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
      leading: Icon(icon),
      title: Text(
        text,
        style: Theme.of(context).textTheme.button,
        // weight: active ? FontWeight.bold : FontWeight.w300,
      ),
    );
  }
}
