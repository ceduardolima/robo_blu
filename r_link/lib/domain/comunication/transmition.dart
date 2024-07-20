import 'package:r_link/domain/robot/robot.dart';
import 'package:r_link/domain/robot/robot_position.dart';

abstract class Transmite {
  /// Cria um List<int> no seguinte formato:
  ///
  /// Considerando um Robo com 2 links e 2 posições, temos:
  /// [Valor inicial, Número de links, Número de posições, Valor da posição 1
  /// do link 1, Valor da posição 1 do link 2, valor da posição 2 do link 1,
  /// valor da posição 2 do link 2]
  static List<int> transmite(Robot robot, List<RobotPosition> positions) {
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
