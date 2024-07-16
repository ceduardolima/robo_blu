import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:r_link/domain/links/link.dart';
import 'package:r_link/domain/robot/robot_position.dart';
import 'package:r_link/domain/utils/point_3d.dart';

class Robot {
  final String name;
  late final RobotPosition initialPosition;
  final List<Link> links;

  Robot({
    required this.name,
    required List<int> initialPosition,
    required this.links,
  }) {
    this.initialPosition = RobotPosition(links.length, initialPosition);
  }

  int linksQuantity() => links.length;

  Point3D toolPosition() => Point3D(0, 0, 0);

  @override
  String toString() =>
      'Robot(name: $name, initialPosition: $initialPosition, links: $links)';

  @override
  int get hashCode => name.hashCode ^ initialPosition.hashCode ^ links.hashCode;
}
