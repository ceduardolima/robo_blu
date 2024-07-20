import 'package:r_link/domain/links/link.dart';
import 'package:r_link/domain/utils/dh_matrix.dart';

class RLink extends Link {
  final double d;

  RLink({
    required this.d,
    required super.a,
    required super.alpha,
    super.bound,
    super.inverse,
    super.offset,
  });

  @override
  String toString() => 'RLink(d: $d, a: $a, alpha: $alpha, bounds: $bound, inverse: $inverse)';

  @override
  bool operator ==(covariant RLink other) {
    if (identical(this, other)) return true;
    return
      other.d == d;
  }

  @override
  int get hashCode => d.hashCode;

  @override
  DHMatrix calculateDH(double value) {
    return DHMatrix(a: a, d: d, theta: value + offset, alpha: alpha);
  }
}
