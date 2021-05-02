import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:stacked/stacked.dart';

class NoticeViewModel extends BaseViewModel {
  final NotificationService currentService = new NotificationServiceFake(); //locator<NotificationService>();

  List<Widget> noticeList = new List<Widget>();

  onRefresh() async {
    // await currentService.getAll();
    notifyListeners();
  }
}
