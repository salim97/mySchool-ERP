import 'package:dio/dio.dart';
import 'package:my_school_web/app/locator.dart';
import 'package:my_school_web/common/common.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectStudentViewModel extends BaseViewModel {
  final StudentService studentService = locator<StudentService>();
  final ParentService parentService = locator<ParentService>();

  List<StudentModel> listStudentModel;
  bool isSearch = false;
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool showSelect = true;
  bool isLoading = true;

  onRefresh() async {
    isLoading = true;
    notifyListeners();

    Response response = await studentService.getAll();

    if (response.statusCode == 200) {
      parentService.parentModel.children.forEach((element) {
        studentService.list.removeWhere((e) => e.id == element.id);
      });
      //
      listStudentModel = studentService.list;
      source.clear();

      listStudentModel.forEach((element) {
        source.add({
          "ID": element.id,
          "Roll No.": element.rollNo,
          "Full Name": element.name,
          "Street Address": element.street_address,
          "Phone": element.phone,
          "Action": element.id
        });
      });
    }
    isLoading = false;
    notifyListeners();
  }

  onTapRow(data) {
    StudentModel child = studentService.list.firstWhere((element) => element.id == data["ID"]);
    parentService.parentModel.children.add(child);
    // print(child.toJson());
    locator<NavigationService>().back();
  }

  onCancel() {
    locator<NavigationService>().back(result: null);
  }

  onSearch(query) async {
    isLoading = true;
    notifyListeners();
    Iterable<StudentModel> ltm = listStudentModel.where((element) {
      if (element.name.contains(query) ||
          // element.middle_name.contains(query) ||
          // element.last_name.contains(query) ||
          // element.phone.contains(query) ||
          // element.first_name.contains(query) ||
          // element.first_name.contains(query) ||
          // element.first_name.contains(query) ||
          element.phone.contains(query)) {
        return true;
      }
      return false;
    });
    source.clear();
    ltm.forEach((element) {
      source.add({
        "ID": element.id,
        "Roll No.": element.rollNo,
        "Full Name": element.name,
        "Street Address": element.street_address,
        "Phone": element.phone,
        "Action": element.id
      });
    });
    // source.addAll(_generateData(n: 1000));
    isLoading = false;
    notifyListeners();
  }
}
