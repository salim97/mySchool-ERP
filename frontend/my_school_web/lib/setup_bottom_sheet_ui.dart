import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

import 'app/locator.dart';

enum BottomSheetType {
  FloatingBox,
  ScrollableList,
  ImageSheet,
}

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.FloatingBox: (context, sheetRequest, completer) => _FloatingBoxBottomSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _FloatingBoxBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  const _FloatingBoxBottomSheet({
    Key key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = request.customData;
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          SizedBox(height: 10),
          // ListTile(
          //   title: Text("English"),
          //   onTap: () {
          //     completer(SheetResponse(responseData: "en"));
          //   },
          // ),
          // ListTile(
          //   title: Text("Francais"),
          //   onTap: () {
          //     completer(SheetResponse(responseData: "fr"));
          //   },
          // ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: data.keys.length,
              itemBuilder: (context, index) {
                String title = data.keys.elementAt(index);
                String code = data.values.elementAt(index)["code"];
                bool myselected = data.values.elementAt(index)["selected"] == "true" ? true : false;
                return ListTile(
                  // selected: myselected,
                  // selectedTileColor: Colors.blue,
                  // leading: myselected ? Icon(Icons.arrow_right) : Icon(MdiIcons.nothin),
                  title: Text(
                    myselected ? "> " + title : "  " + title,
                    style: TextStyle(color: myselected ? Colors.blue : Colors.black),
                  ),
                  onTap: () {
                    completer(SheetResponse(responseData: code));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
