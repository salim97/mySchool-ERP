import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MyInputWidget{
  
  static Widget userInputText(
      {String title,
      String hintText,
      TextEditingController textEditingController,
      bool mustFill = false,
      Function(String) onValidator = null,
      bool obscureText = false}) {
    if (hintText == null) hintText = title;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Text(title),
                  mustFill
                      ? Text(
                          " *",
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              )),
          TextFormField(
            obscureText: obscureText,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
            ),
            validator: mustFill == true
                ? onValidator == null
                    ? (value) {
                        if (value.isEmpty) {
                          return "Please provide a " + title;
                        }
                      }
                    : onValidator
                : null,
          )
        ],
      ),
    );
  }

  static Widget userInputTime({
    String title,
    String hintText,
    TextEditingController textEditingController,
    bool mustFill = false,
  }) {
    if (hintText == null) hintText = title;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Text(title),
                  mustFill
                      ? Text(
                          " *",
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              )),
          DateTimeField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
            ),
            format: DateFormat("HH:mm"),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ],
      ),
    );
  }

}