// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:r_link/domain/utils/bound.dart';
import 'package:r_link/domain/comunication/transmition.dart';
import 'package:r_link/domain/utils/dh_matrix.dart';

abstract class Link {
  final double a;
  final double alpha;
  final Bound? bound;
  final bool inverse;
  final double offset;

  Link({
    required this.a,
    required this.alpha,
    this.inverse = false,
    this.bound,
    this.offset = 0.0,
  });

  DHMatrix calculateDH(double value);

  @override
  String toString() {
    return 'Link(a: $a, alpha: $alpha, bound: $bound, inverse: $inverse)';
  }
}
