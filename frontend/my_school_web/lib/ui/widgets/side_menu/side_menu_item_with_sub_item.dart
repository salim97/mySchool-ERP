import 'package:my_school_web/theme.dart';
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
    return new ExpansionTile(
      backgroundColor: MyTheme.drawer_subitem,
      leading: Icon(icon),
      title: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
      children: children,
    );
  }
}
