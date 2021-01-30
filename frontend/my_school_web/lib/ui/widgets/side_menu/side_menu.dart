import 'package:auto_route/auto_route.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/theme.dart';
import 'package:my_school_web/ui/widgets/navbar/navbar_logo.dart';
import 'package:my_school_web/ui/widgets/side_menu/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/ui/widgets/side_menu/side_menu_item_with_sub_item.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    Map menuJSON = appProvider.sideMenu;
    List<Widget> menuWidget = new List<Widget>();
    menuWidget.add(NavBarLogo());
    menuJSON.forEach((key1, value1) {
      if (value1 == "divider") {
        menuWidget.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              height: 4,
              width: 130,
              color: Colors.white,
            ),
          ),
        ));
        return;
      }
      if (value1["children"] == null) {
        menuWidget.add(
          SideMenuItemDesktop(
            icon: value1["icon"],
            text: key1,
            active: appProvider.currentPage == key1,
            onTap: () {
              locator<NavigationService>().replaceWith(value1["route name"]);
            },
          ),
        );
        return;
      }

      List<Widget> subItems = new List<Widget>();
      Map children = value1["children"];
      children.forEach((key2, value2) {
        subItems.add(
          SideMenuItemDesktop(
            icon: value2["icon"],
            text: key2,
            active: appProvider.currentPage == key2,
            onTap: () {
              locator<NavigationService>().replaceWith(value2["route name"]);
            },
          ),
        );
      });
      menuWidget.add(SideMenuItemWidthSubItemDesktop(
        icon: value1["icon"],
        text: key1,
        active: appProvider.currentPage == key,
        children: subItems,
      ));
    });
    final theme = Theme.of(context);
    // theme.textTheme.button = theme.textTheme.button.apply(color: Colors.white);
    return Theme(
      data: theme.copyWith(
        // textTheme: theme.textTheme.copyWith(button: theme.textTheme.button.copyWith(color: Colors.white)),
        unselectedWidgetColor: Colors.white,
        accentColor: Colors.white,
      ),
      child: ListTileTheme(
        iconColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: MyTheme.drawer_item,
            // gradient: LinearGradient(
            //   colors: [Colors.indigo, Colors.indigo.shade600],
            // ),
            boxShadow: [BoxShadow(color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)],
          ),
          width: 250,
          child: ListView(
            children: menuWidget,
          ),
        ),
      ),
    );
  }
}
