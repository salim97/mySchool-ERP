import 'dart:io';

import 'package:common/common.dart';
import 'package:common/models/user_model.dart';
import 'package:common/services/teacher_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/common.dart';
import 'package:logger/logger.dart';

import 'testList.dart';

void main() async {
  
  await testAuthService();
  // await testStudentService();
  // await testParentService();

//   test('main', () {
//     /*
//     var logger = new Logger();
//     FakeTeacherService fakeTeacherService = new FakeTeacherService();
//     Directory current = Directory.current;
//     // logger.d(current);
//     {
//       var dir = new Directory(current.path + "\\lib\\models");
//       List contents = dir.listSync();
//       for (var fileOrDir in contents) {
//         if (fileOrDir is File && !fileOrDir.path.contains(".g.dart")) {
//           String fileName = fileOrDir.path.split("\\").last;
//           print("export './models/" + fileName + "';");
//         }
//       }
//     }

//         {
//       var dir = new Directory(current.path + "\\lib\\services");
//       List contents = dir.listSync();
//       for (var fileOrDir in contents) {
//         if (fileOrDir is File && !fileOrDir.path.contains(".g.dart")) {
//           String fileName = fileOrDir.path.split("\\").last;
//           print("export './services/" + fileName + "';");
//         }
//       }
//     }
//     expect(true, true);
// */

// //     final calculator = Calculator();
// //     expect(calculator.addOne(2), 3);
// //     expect(calculator.addOne(-7), -6);
// //     expect(calculator.addOne(0), 1);
// //     expect(() => calculator.addOne(null), throwsNoSuchMethodError);
//   });
}
