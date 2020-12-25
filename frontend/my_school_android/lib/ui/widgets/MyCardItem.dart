import 'package:flutter/material.dart';

import 'MyUtils.dart';

class CustomWidget extends StatefulWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final String headline;
  final String icon;

  const CustomWidget({
    Key key,
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
    @required this.headline,
    @required this.icon,
  })  : assert(index != null),
        assert(isSelected != null),
        assert(onSelect != null),
        super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  String title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.headline;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.isSelected ? Color(0xffe1bee7) : Color(0xfff3e5f5),
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.isSelected
                    ? LinearGradient(
                        begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.blueAccent, Colors.deepPurpleAccent])
                    : LinearGradient(colors: [Colors.white, Colors.white]),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      widget.icon.toString(),
                      color: widget.isSelected ? Colors.white : Colors.blue,
                      width: 30.0,
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      title != null ? title : '...',
                      style: TextStyle(
                        color: widget.isSelected ? Colors.white : Colors.grey,
                        fontSize: 10.0,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
