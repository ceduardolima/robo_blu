// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:r_link/domain/links/link.dart';
import 'package:r_link/domain/utils/dh_matrix.dart';

class PLink extends Link {
  final double theta;
  PLink({
    required super.a,
    required super.alpha,
    required this.theta,
    super.bound,
    super.inverse,
  });

  @override
  DHMatrix calculateDH(double value) {
    return DHMatrix(a: a, d: value, theta: theta, alpha: alpha);
  }

  @override
  String transmite() {
    // TODO: implement transmite
    throw UnimplementedError();
  }

  @override
  String toString() =>
      'PLink(theta: $theta, a: $a, alpha: $alpha, bound: $bound, inverse: $inverse)';
}
