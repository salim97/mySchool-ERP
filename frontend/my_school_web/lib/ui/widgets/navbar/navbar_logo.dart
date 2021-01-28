import 'package:flutter/material.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, bottom: 8.0),
      child: SizedBox(
        height: 60,
        width: 250,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
          color: Colors.white,
          child: Image.asset(
            "assets/images/splash_logo.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
