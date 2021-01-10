import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  final VoidCallback onButtonClicked;
  final String buttonTitle;

  const NoConnectionScreen({Key key, this.onButtonClicked, this.buttonTitle = "Retry"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_page/1_No Connection.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 100,
            left: 30,
            child: FlatButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              onPressed: onButtonClicked,
              child: Text(
                buttonTitle.toUpperCase(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
