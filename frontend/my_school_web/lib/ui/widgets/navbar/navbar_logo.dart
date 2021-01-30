import 'package:flutter/material.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
<<<<<<< HEAD
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
=======
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: SizedBox(
        height: 50,
        width: 100,
        child: Image.asset(
          "assets/images/logo.png",
>>>>>>> 4a6ba8ae984bc3feb829525b48d4361456ad444a
        ),
      ),
    );
  }
}
