// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:matrices/matrices.dart';
import 'package:r_link/domain/comunication/transmition.dart';
import 'package:r_link/domain/utils/dh_matrix.dart';

import '../../utils/log.dart';
import '../links/link.dart';

class RobotPosition {
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
    Matrix? m;
    for (int i = 0; i < linksQuantity; i++) {
      final r = link[i].calculateDH(positions[i].toDouble()).dh;
      if (m == null) {
        m = r;
      } else {
        m = m * r;
      }
    }
    return m!;
  }

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
