import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:r_link/domain/links/link.dart';
import 'package:r_link/domain/utils/point_3d.dart';

class Robot {
  final String name;
  final List<int> initialPosition;
  final List<Link> links;

  Robot({
    required this.name,
    required this.initialPosition,
    required this.links,
  }) : assert(initialPosition.length == links.length,
            "Posicição inicial inválida, ela deve conter ${links.length} elementos");

  Robot copyWith({
    String? name,
    List<int>? initialPosition,
    List<Link>? links,
  }) {
    return Robot(
      name: name ?? this.name,
      initialPosition: initialPosition ?? this.initialPosition,
      links: links ?? this.links,
    );
  }

  int linksQuantity() => links.length;

  Point3D toolPosition() => Point3D(0, 0, 0);

  @override
  String toString() =>
      'Robot(name: $name, initialPosition: $initialPosition, links: $links)';

  @override
  bool operator ==(covariant Robot other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.initialPosition, initialPosition) &&
        listEquals(other.links, links);
  }

  @override
  int get hashCode => name.hashCode ^ initialPosition.hashCode ^ links.hashCode;
}
