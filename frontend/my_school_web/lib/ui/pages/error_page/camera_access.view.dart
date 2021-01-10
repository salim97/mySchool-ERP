import 'package:flutter/material.dart';

class CameraAccessScreen extends StatelessWidget {
  final VoidCallback onButtonClicked;
  final String buttonTitle;

  const CameraAccessScreen({Key key, this.onButtonClicked, this.buttonTitle = "Allow"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_page/21_No Camera Access.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 13),
                    blurRadius: 25,
                    color: Color(0xFF5666C2).withOpacity(0.17),
                  ),
                ],
              ),
              child: FlatButton(
                color: Color(0xFFED72AD),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                onPressed: onButtonClicked,
                child: Text(
                  buttonTitle.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
