// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Bound {
  final double upper;
  final double lower;
  Bound({
    required this.upper,
    required this.lower,
  });

  Bound copyWith({
    double? upper,
    double? lower,
  }) {
    return Bound(
      upper: upper ?? this.upper,
      lower: lower ?? this.lower,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'upper': upper,
      'lower': lower,
    };
  }

  factory Bound.fromMap(Map<String, dynamic> map) {
    return Bound(
      upper: map['upper'] as double,
      lower: map['lower'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bound.fromJson(String source) => Bound.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Bound(upper: $upper, lower: $lower)';

  @override
  bool operator ==(covariant Bound other) {
    if (identical(this, other)) return true;

    return
      other.upper == upper &&
      other.lower == lower;
  }

  @override
  int get hashCode => upper.hashCode ^ lower.hashCode;
}
