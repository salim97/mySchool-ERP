import 'package:flutter/material.dart';

class NoFileScreen extends StatelessWidget {
  final VoidCallback onButtonClicked;
  final String buttonTitle;

  const NoFileScreen({Key key, this.onButtonClicked, this.buttonTitle = "Home"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_page/20_File Not Found.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.14,
            left: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 25,
                    color: Colors.black.withOpacity(0.17),
                  ),
                ],
              ),
              child: FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                onPressed: onButtonClicked,
                child: Text(
                  buttonTitle.toUpperCase(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
