import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

var l = new Logger();
testAuthService() async {
  AuthService _authService = new AuthServiceImpl();
  var response = await _authService.login(
    email: "admin1@email.com",
    password: "azerty2020",
  );

  l.d(response.statusCode);
  l.d(_authService.userModel.toJson());
  return;
  Response r;

  r = await _authService.me();
  l.d(r.statusCode);

  r = await _authService.logout();
  l.d(r.statusCode);

  r = await _authService.me();
  l.d(r.statusCode);
  l.d(r.data);
}

testStudentService() async {
  AuthService _authService = new AuthServiceImpl();
  var response = await _authService.login(
    email: "admin1@email.com",
    password: "azerty2020",
  );
  l.d(response.data);

  // StudentModel studentModel = new StudentModel();
  // studentModel.gender = "male";
  // studentModel.date_of_birth = "2020-12-31";
  // studentModel.userAccount.id = "5fee0fc442d0bd4064a84dd0";

  // print(studentModel.toJson());

  StudentService _studentService = new StudentServiceImpl();
  // response = await _studentService.add(studentModel);
  // l.d(response.data);
  // l.d(response.statusCode);

  response = await _studentService.getAll();
  l.d(response.data);
  l.d(response.statusCode);
  _studentService.list.forEach((element) {
    l.i("element.toJson()");
    l.i(element.toJson());
    // l.i(element.userAccount.toJson());
  });
  return;
  _studentService.list.first.city_name = "city dayra ki zebi";
  response = await _studentService.update(_studentService.list.first);
  l.d(response.data);
  l.d(response.statusCode);
  _studentService.list.forEach((element) {
    l.i("element.toJson()");
    l.i(element.toJson());
    // l.i(element.userAccount.toJson());
  });

  // response = await _studentService.delete(_studentService.listStudentModel.first);
  // l.d(response.data);
  // l.d(response.statusCode);
  // _studentService.listStudentModel.forEach((element) {
  //   l.i("element.toJson()");
  //   l.i(element.toJson());
  //   // l.i(element.userAccount.toJson());
  // });
}

testParentService() async {
  AuthService _authService = new AuthServiceImpl();
  var response = await _authService.login(
    email: "admin1@email.com",
    password: "azerty2020",
  );
  l.d(response.data);

  ParentModel studentModel = new ParentModel();
  studentModel.phone = "0tit tit allow we cava zentit ?";
  studentModel.gender = "male";
  studentModel.date_of_birth = "2020-12-31";
  studentModel.userAccount.id = "5fee0fc442d0bd4064a84dd0";

  print(studentModel.toJson());

  ParentService _studentService = new ParentServiceImpl();
  // response = await _studentService.add(studentModel);
  l.d(response.data);
  l.d(response.statusCode);

  response = await _studentService.getAll();
  l.d(response.data);
  l.d(response.statusCode);
  _studentService.list.forEach((element) {
    l.i("element.toJson()");
    l.i(element.toJson());
    // l.i(element.userAccount.toJson());
  });

  _studentService.list.first.children.add(StudentModel(id: "5fef6bc609c4b7250cde9498"));
  response = await _studentService.update(_studentService.list.first);
  l.d(response.data);
  l.d(response.statusCode);
  _studentService.list.forEach((element) {
    l.i("element.toJson()");
    l.i(element.toJson());

    l.i(element.children.first.toJson());
    // l.i(element.userAccount.toJson());
  });

  // response = await _studentService.delete(_studentService.listParentModel.first);
  // l.d(response.data);
  // l.d(response.statusCode);
  // _studentService.listParentModel.forEach((element) {
  //   l.i("element.toJson()");
  //   l.i(element.toJson());
  //   // l.i(element.userAccount.toJson());
  // });
}
