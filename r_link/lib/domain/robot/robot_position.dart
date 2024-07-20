// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:r_link/domain/comunication/transmition.dart';

class RobotPosition implements Transmite {
  final int linksQuantity;
  final List<int> positions;

  RobotPosition(this.linksQuantity, this.positions)
      : assert(linksQuantity == positions.length,
            "Número de juntas deve ser igual ao número de positções");

  @override
  String transmite() {
    return positions.fold("", (previousValue, element) => "$previousValue-$element");
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
