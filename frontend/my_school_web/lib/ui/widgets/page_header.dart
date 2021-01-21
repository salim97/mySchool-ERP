import 'package:flutter/material.dart';
import 'package:my_school_web/provider/app.provider.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class PageHeader extends StatelessWidget {
  String title;

  PageHeader({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (title == null) title = Provider.of<AppProvider>(context).getNameOfThisRoute(ModalRoute.of(context).settings.name);
    return Row(
      children: [
        // SizedBox(width: 30,),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CustomText(
            text: title,
            size: 40,
            weight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
