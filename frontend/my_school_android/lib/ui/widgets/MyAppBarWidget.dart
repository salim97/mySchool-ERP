import 'package:flutter/material.dart';

class AppBarWidget {
  static Widget header(BuildContext context, String title) {

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      // actions: [
      //   CircleAvatar(
      //     radius: 25.0,
      //     backgroundImage: AssetImage("assets/images/unknown_profile.png"),
      //     backgroundColor: Colors.transparent,
      //   ),
      // ],
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      flexibleSpace: Image(
        image: AssetImage('assets/images/tool_bar_bg.png'),
        // image: NetworkImage('assets/images/tool_bar_bg.png'),
        //width: MediaQuery.of(context).size.width,
        height: 200.0,
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.transparent,
      elevation: 5.0,
    );
  }
}
