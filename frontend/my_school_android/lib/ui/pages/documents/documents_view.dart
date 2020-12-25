import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:stacked/stacked.dart';

import 'documents_view_model.dart';

class DocumentsView extends StatefulWidget {
  @override
  _DocumentsViewState createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<DocumentsViewModel>.reactive(
      viewModelBuilder: () => DocumentsViewModel(),
      builder: (
        BuildContext context,
        DocumentsViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBarWidget.header(context, 'My Documents'),
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                docItem(title: "Birth Certificate", subTitle: "birth-certificate.pdf"),
                docItem(title: "Transfer Certificate", subTitle: "transfer-certificate.pdf"),
                docItem(title: "Birth Certificate", subTitle: "birth-certificate.pdf"),
                docItem(title: "Transfer Certificate", subTitle: "transfer-certificate.pdf"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget docItem({String title, String subTitle}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ListTile(
            title: Text(title),
            subtitle: Text(subTitle),
            trailing: FlatButton(
              color: Colors.green,
              onPressed: () {},
              child: Text(
                "Download",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          height: 0.5,
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [Colors.purple, Colors.deepPurple]),
          ),
        ),
      ],
    );
  }
}
