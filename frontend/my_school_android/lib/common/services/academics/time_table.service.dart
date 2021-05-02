import 'package:dio/dio.dart';

import '../../common.dart';

abstract class TimeTableService extends RestAPI {
  List<TimeTableModel> list;
  Future<Response> getAll();
  Future<Response> add(TimeTableModel model);
  Future<Response> update(TimeTableModel model);
  Future<Response> delete(TimeTableModel model);
  String endPointURL;
}

class TimeTableServiceImpl extends RestAPI implements TimeTableService {
  @override
  List<TimeTableModel> list;
  String endPointURL;
  TimeTableServiceImpl() {
    endPointURL = serverIP + "/api/v1/academics/timeTable_service";
    list = new List<TimeTableModel>();
  }
  @override
  Future<Response> add(TimeTableModel model) async {
    Response response = await myDioPOST(
      url: endPointURL,
      data: model.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }

  @override
  Future<Response> delete(TimeTableModel model) async {
    Response response = await myDioDELETE(
      url: endPointURL + "/" + model.id,
    );
    if (response.statusCode == 204) {
      list.removeWhere((element) => element.id == model.id);
    }
    return response;
  }

  @override
  Future<Response> getAll() async {
    Response response = await myDioGET(
      url: endPointURL,
    );
    // logger.d(response.data);
    // logger.d(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> temp = response.data["data"]["data"];
      list.clear();
      temp.forEach((element) {
        list.add(TimeTableModel.fromJson(element));
      });
    }
    return response;
  }

  @override
  Future<Response> update(TimeTableModel model) async {
    Response response = await myDioPATCH(
      url: endPointURL + "/" + model.id,
      data: model.toJson(),
    );
    if (response.statusCode == 200) {
      // userModel = new UserModel.fromJson(response.data["data"]["user"]);
    }
    return response;
  }
}

class TimeTableServiceFake extends RestAPI implements TimeTableService {
  @override
  List<TimeTableModel> list;
  TimeTableModel model;
  String endPointURL;
  TimeTableServiceFake() {
    endPointURL = serverIP + "/api/v1/academics/classRoom_service";
    list = new List<TimeTableModel>();
    list.clear();
    list.add(timeTableModel(groupid: GroupModel(name: "Group 1", section: SectionModel(name: "Section 1")), children: [
      OneTimeTable(
        day: "dimanche",
        classRoomModel: ClassRoomModel(room_number: "A01"),
        teacherSubjectModel: TeacherSubjectModel(subjectid: SubjectModel(name: "Math", type: "TD")),
        workingHoursModel: WorkingHoursModel(startTime: "08:00", endTime: "09:00"),
      )
    ]));
  }
  TimeTableModel timeTableModel({GroupModel groupid, List<OneTimeTable> children}) {
    TimeTableModel tmp = new TimeTableModel();
    tmp.groupid = groupid;
    tmp.children = children;
    return tmp;
  }

  @override
  Future<Response> add(TimeTableModel model) async {
    list.add(model);
    return null;
  }

  @override
  Future<Response> delete(TimeTableModel model) async {
    list.removeWhere((element) => element.id == model.id);

    return null;
  }

  @override
  Future<Response> getAll() async {
    return null;
  }

  @override
  Future<Response> update(TimeTableModel model) async {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).id == model.id) list[i] = model;
    }
    return null;
  }
}
