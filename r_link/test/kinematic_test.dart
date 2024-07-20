import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:r_link/domain/kinematic/kinematic.dart';
import 'package:r_link/domain/robot/robot_position.dart';
import 'package:r_link/mock/robot_mock.dart';

void main() {
  test("Teste string de comunicação", () {
    const value = "D-3-2-0-0-0-0-0-0";
    final exc = KinematicCommunication.direct(robot, [RobotPosition(3, [0,0,0]), RobotPosition(3, [0,0,0])]);
    expect(value, equals(exc));
  });
}