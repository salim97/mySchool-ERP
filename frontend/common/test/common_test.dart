import 'package:flutter_test/flutter_test.dart';

import 'package:common/common.dart';
import 'package:logger/logger.dart';

void main() {
  test('main', () {
    var logger = new Logger();
    TeacherModel tm = new TeacherModel();
    tm.first_name = " test ";
    logger.d(tm.toJson());
    expect(true, true);
//     final calculator = Calculator();
//     expect(calculator.addOne(2), 3);
//     expect(calculator.addOne(-7), -6);
//     expect(calculator.addOne(0), 1);
//     expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });
}
