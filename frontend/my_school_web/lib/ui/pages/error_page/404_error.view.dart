import 'package:flutter/material.dart';

class Error404Screen extends StatelessWidget {
  final VoidCallback onButtonClicked;
  final String buttonTitle;

  const Error404Screen({Key key, this.onButtonClicked, this.buttonTitle = "Go Home"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_page/2_404 Error.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: FlatButton(
              color: Color(0xFF6B92F2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              onPressed: onButtonClicked,
              child: Text(
                buttonTitle.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
