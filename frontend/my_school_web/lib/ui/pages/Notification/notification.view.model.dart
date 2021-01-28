import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/common/common.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // services
  final NotificationService currentService = locator<NotificationService>();
  final AuthService authService = locator<AuthService>();
  NotificationModel currentModel = new NotificationModel();
  List<String> selectedItems = new List<String>();

  TeacherService teacherService = locator<TeacherService>();
  ParentService parentService = locator<ParentService>();
  StudentService studentService = locator<StudentService>();

  // edit line widget to add or edit data
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  //tableview needs this variables
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = false;
  bool isAddElementVisible = false;
  bool viaFCM = true;
  bool viaEmail = false;
  List<DatatableHeader> headers = [
    DatatableHeader(text: "ID", value: "ID", show: false, sortable: true, textAlign: TextAlign.right),
    DatatableHeader(text: "Date", value: "Date", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "sender", value: "sender", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Title", value: "Title", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Message", value: "Message", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Type", value: "Type", show: true, sortable: true, textAlign: TextAlign.left),
    DatatableHeader(text: "Send To", value: "Send To", show: true, sortable: true, textAlign: TextAlign.left),
  ];
  init() async {
    // await teacherService.getAll();
    // await studentService.getAll();
    // await parentService.getAll();
  }

  onRefresh() async {
    isLoading = true;
    notifyListeners();

    Response response = await currentService.getAll();
    if (response.statusCode == 200) {
      source.clear();

      currentService.list.forEach((element) {
        source.add({
          "ID": element.id,
          "Date": element.createdAt,
          "sender": element.senderInfo.email,
          "Title": element.title,
          "Message": element.message,
          "Type": element.type == "fcm" ? "Phone Notification" : element.type,
          "Send To": element.topic,
          "Action": element.id,
        });
      });
    }
    isLoading = false;
    notifyListeners();
  }

  onCreateNew() async {
    var now = new DateTime.now();
    String random = now.millisecondsSinceEpoch.toString();
    titleController.text = random;
    messageController.text = random;
    selectedItems.clear();
    isAddElementVisible = true;
    notifyListeners();
  }

  onValid() async {
    currentModel.title = titleController.text;
    currentModel.message = messageController.text;
    currentModel.type = "fcm";
    print(currentModel.toJson());
    selectedItems.forEach((element) {
      if (currentModel.topic == null) currentModel.topic = new List<String>();
      currentModel.topic.add(element);
    });
    print(currentModel.toJson());
    await currentService.add(currentModel);

    await onCancel();
    await onRefresh();
  }

  onCancel() async {
    titleController.text = "";
    messageController.text = "";
    if (currentModel.topic != null) currentModel.topic.clear();
    selectedItems.clear();
    isAddElementVisible = false;
    notifyListeners();
  }

  onDelete(id) async {
    final _bottomSheetService = locator<BottomSheetService>();
    var response = await _bottomSheetService.showBottomSheet(
        title: "Are you sure you want delete this record ?",
        description: "click on Yes to confirm suppresion of the record",
        confirmButtonTitle: "YES",
        cancelButtonTitle: "NO");
    if (response == null) return;
    if (response.confirmed) {
      await currentService.delete(NotificationModel(id: id));
      await onRefresh();
    }
  }

  onSearch(query) async {
    print(query);
    // var ltm = currentService.list.where((element) {
    //   if (element.capacity == query || element.room_number.contains(query)) {
    //     return true;
    //   }
    //   return false;
    // });
    // source.clear();
    // ltm.forEach((element) {
    //   source.add({
    //     "ID": element.id,
    //     "room_number": element.room_number,
    //     "capacity": element.capacity,
    //   });
    // });
    notifyListeners();
  }
}
