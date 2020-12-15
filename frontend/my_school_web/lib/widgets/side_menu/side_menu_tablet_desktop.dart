import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_school_web/locator.dart';
import 'package:my_school_web/provider/app_provider.dart';
import 'package:my_school_web/services/navigation_service.dart';
import 'package:my_school_web/widgets/navbar/navbar_logo.dart';
import 'package:my_school_web/widgets/side_menu/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/widgets/side_menu/side_menu_item_with_sub_item.dart';
import 'package:provider/provider.dart';

class SideMenuTabletDesktop extends StatelessWidget {
  // Widget jsonToWidget({String key, Map value}) {
  //   return SideMenuItemDesktop(
  //     icon: value["icon"],
  //     text: key,
  //     active: appProvider.currentPage == key,
  //     onTap: () {
  //       appProvider.changeCurrentPage(key);
  //       locator<NavigationService>().navigateTo(value["route name"]);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    Map menuJSON = appProvider.sideMenu;
    List<Widget> menuWidget = new List<Widget>();
    menuWidget.add(NavBarLogo());
    menuJSON.forEach((key1, value1) {
      if (value1["children"] == null) {
        menuWidget.add(
          SideMenuItemDesktop(
            icon: value1["icon"],
            text: key1,
            active: appProvider.currentPage == key1,
            onTap: () {
              appProvider.changeCurrentPage(key1);
              locator<NavigationService>().navigateTo(value1["route name"]);
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
              appProvider.changeCurrentPage(key2);
              locator<NavigationService>().navigateTo(value2["route name"]);
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

    return Container(
      decoration: BoxDecoration(color: Colors.white,
          // gradient: LinearGradient(
          //   colors: [Colors.indigo, Colors.indigo.shade600],
          // ),
          boxShadow: [BoxShadow(color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)]),
      width: 250,
      child: Container(
        child: ListView(
          children: menuWidget,
        ),
      ),
    );
  }
}
