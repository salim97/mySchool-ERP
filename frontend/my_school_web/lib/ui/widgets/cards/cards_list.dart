import 'package:my_school_web/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card_item.dart';

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      height: 120,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardItem(
              icon: Icons.monetization_on_outlined,
              title: "ÉLÈVES",
              subtitle: "",
              value: "31+",
              color1: Color(0xfffb6b47),
              color2: Color(0xfffb6b47),
            ),
            CardItem(
              icon: Icons.shopping_basket_outlined,
              title: "ENSEIGNANTES",
              subtitle: "",
              value: "5+",
              color1: Color(0xffff911b),
              color2: Color(0xffff911b),
            ),
            CardItem(
              icon: Icons.delivery_dining,
              title: "PARENTE",
              subtitle: "",
              value: "31+",
              color1: Color(0xffffc000),
              color2: Color(0xffffc000),
            ),
            CardItem(
              icon: Icons.delivery_dining,
              title: "DES CLASSES",
              subtitle: "",
              value: "31+",
              color1: Color(0xffa7c850),
              color2: Color(0xffa7c850),
            ),
          ],
        ),
      ),
    );
  }
}
