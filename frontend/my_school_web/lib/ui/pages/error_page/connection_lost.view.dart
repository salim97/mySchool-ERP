import 'package:flutter/material.dart';

class ConnectionLostScreen extends StatelessWidget {
  final VoidCallback onButtonClicked;
  final String buttonTitle;

  const ConnectionLostScreen({Key key, this.onButtonClicked, this.buttonTitle = "retry"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_page/10_Connection Lost.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 25,
                    color: Color(0xFF59618B).withOpacity(0.17),
                  ),
                ],
              ),
              child: FlatButton(
                color: Color(0xFF6371AA),
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
