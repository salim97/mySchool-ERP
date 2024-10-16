import 'package:flutter/material.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:stacked/stacked.dart';

import 'notice_view_model.dart';

class NoticeView extends StatefulWidget {
  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoticeViewModel>.reactive(
      viewModelBuilder: () => NoticeViewModel(),
      onModelReady: (model) {
        model.onRefresh();
      },
      builder: (
        BuildContext context,
        NoticeViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBarWidget.header(context, 'Notice Board'),
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: model.currentService.list.length,
              itemBuilder: (BuildContext context, int index) {
                return noticeItem(
                  title: model.currentService.list.elementAt(index).title,
                  subTitle: model.currentService.list.elementAt(index).message,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget noticeItem({String title, String subTitle}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ListTile(
            title: Text(title),
            subtitle: Text(subTitle),
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
