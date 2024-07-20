// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:matrices/matrices.dart';
import 'package:r_link/domain/comunication/transmition.dart';
import 'package:r_link/domain/utils/dh_matrix.dart';

import '../links/link.dart';

class RobotPosition implements Transmite {
  final int linksQuantity;
  final List<int> positions;

  RobotPosition(this.linksQuantity, this.positions)
      : assert(linksQuantity == positions.length,
            "Número de juntas deve ser igual ao número de positções");

  Matrix calculateDH(List<Link> link) {
    if (link.length != linksQuantity) {
      throw ArgumentError(
          "Número de links diverge do número de links da RobotPosition");
    }
    Matrix result = Matrix.one(4, 4);
    for (int i = 0; i < linksQuantity; i++) {
      result = result * link[i].calculateDH(positions[i].toDouble());
    }
    return result;
  }

  @override
  String transmite() {
    return positions.fold(
        "", (previousValue, element) => "$previousValue-$element");
  }

  @override
  String toString() {
    String toString = "[";
    for (int i = 0; i < positions.length - 1; i++) {
      toString += "${positions[i]}, ";
    }
    toString += "${positions.last}]";
    return toString;
  }
}
