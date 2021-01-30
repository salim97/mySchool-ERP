import 'package:flutter/material.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SizedBox(
        height: 60,
        width: 250,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          color: Colors.white,
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
      ),
    );
  }
}
