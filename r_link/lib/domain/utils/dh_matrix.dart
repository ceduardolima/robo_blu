// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:matrices/matrices.dart';

/// Representação da matiz DH
class DHMatrix {
  final double a;
  final double d;
  late final double theta;
  late final double alpha;

  DHMatrix({
    required this.a,
    required this.d,
    required double theta,
    required double alpha,
  }) {
    this.theta = _toRad(theta);
    this.alpha = _toRad(alpha);
  }

  double _toRad(double deg) {
    return pi * deg / 180.0;
  }

  Matrix get dh =>
      Matrix.fromList([
        _line1(),
        _line2(),
        _line3(),
        _line4(),
      ]);

  List<double> _line1() {
    return [
      cos(theta),
      -1 * sin(theta) * cos(alpha),
      sin(theta) * sin(alpha),
      a * cos(theta)
    ];
  }

  List<double> _line2() {
    return [
      sin(theta),
      cos(theta) * cos(alpha),
      -1 * cos(theta) * sin(alpha),
      a * sin(theta)
    ];
  }

  List<double> _line3() {
    return [0, sin(alpha), cos(alpha), d];
  }

  List<double> _line4() => [0, 0, 0, 1];
}
