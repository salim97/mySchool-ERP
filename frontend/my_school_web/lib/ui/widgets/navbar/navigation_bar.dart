import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/app/router.gr.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:my_school_web/provider/auth.provider.dart';
import 'package:my_school_web/ui/widgets/custom_text.dart';
import 'package:my_school_web/common/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationBar extends StatelessWidget {
  // final GlobalKey<ScaffoldState> scaffoldState;

  const NavigationBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)]),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, //change here don't //worked
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // IconButton(
              //   icon: Icon(Icons.menu),
              //   onPressed: () {},
              // ),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications),
                    // label: CustomText(
                    //   text: '',
                    // ),
                    onPressed: () {},
                  ),
                  Positioned(
                    top: 4,
                    left: 9,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              // FlatButton.icon(
              //   icon: Icon(Icons.settings),
              //   label: CustomText(
              //     text: 'Paramètres',
              //   ),
              //   onPressed: () {},
              // ),
              // SizedBox(
              //   width: 20,
              // ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // CustomText(
                  //   text: 'Nom Prenom',
                  // ),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0), //position where you want to show the menu on screen
                        items: [
                          PopupMenuItem<String>(child: const Text('Your profile'), value: '1'),
                          PopupMenuItem<String>(child: const Text('Settings'), value: '2'),
                          PopupMenuItem<String>(child: const Text('Sign out'), value: '3'),
                        ],
                        elevation: 8.0,
                      ).then<void>((String itemSelected) async {
                        if (itemSelected == null) return;

                        if (itemSelected == "1") {
                          //  await locator<NavigationService>().navigateTo(Routes.teachersView);
                          locator<NavigationService>().replaceWith(Routes.dashboardView);
                        } else if (itemSelected == "2") {
                          locator<NavigationService>().replaceWith(Routes.toDoPage);
                        } else {
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          authProvider.status = Status.Unauthenticated;
                          authProvider.notifyListeners();
                        }
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
