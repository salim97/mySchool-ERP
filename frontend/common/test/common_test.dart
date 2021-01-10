import 'dart:io';

import 'package:common/common.dart';
import 'package:common/models/users/user.model.dart';
import 'package:common/services/users/teacher.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/common.dart';
import 'package:logger/logger.dart';

import 'testList.dart';

void main() async {
  // await testAuthService();
  // await testStudentService();
  // await testParentService();

  Directory current = Directory.current;
  printListOffiles(current.path + "\\lib\\models", "./models/");
  print("");
  printListOffiles(current.path + "\\lib\\services", "./services/");

  // logger.d(current);

  // {
  //   var dir = new Directory(current.path + "\\lib\\services");
  //   List contents = dir.listSync();
  //   for (var fileOrDir in contents) {
  //     if (fileOrDir is File && !fileOrDir.path.contains(".g.dart")) {
  //       String fileName = fileOrDir.path.split("\\").last;
  //       print("export './services/" + fileName + "';");
  //     }
  //   }
  // }

//   test('main', () {
//     /*

//     expect(true, true);
// */

// //     final calculator = Calculator();
// //     expect(calculator.addOne(2), 3);
// //     expect(calculator.addOne(-7), -6);
// //     expect(calculator.addOne(0), 1);
// //     expect(() => calculator.addOne(null), throwsNoSuchMethodError);
//   });
}

printListOffiles(String path, String exportTo) {
  var dir = new Directory(path);
  List contents = dir.listSync();
  for (var fileOrDir in contents) {
    if (fileOrDir is File && !fileOrDir.path.contains(".g.dart")) {
      String fileName = fileOrDir.path.split("\\").last;
      print("export '" + exportTo + fileName + "';");
    }
    if (fileOrDir is Directory) printListOffiles(fileOrDir.path, exportTo + fileOrDir.path.split("\\").last + "/");
  }
}
