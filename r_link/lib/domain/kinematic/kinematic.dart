import 'package:r_link/domain/robot/robot.dart';

import '../robot/robot_position.dart';

abstract class KinematicCommunication {
  static List<int> direct(Robot robot, List<RobotPosition> positions) {
    String communicationStr = "D";
    int numPos = positions.length;
    int numLinks = robot.links.length;
    final a = [communicationStr.codeUnits[0], numLinks, numPos];
    for (final j in positions) {
      a.addAll(j.positions);
    }
    return a;
  }
}