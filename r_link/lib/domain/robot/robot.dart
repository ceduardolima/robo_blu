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

  Point3D toolPosition(RobotPosition pos) {
    final res = pos.calculateDH(links);
    return Point3D(res[0][3], res[1][3], res[2][3]);
  }

  @override
  String toString() =>
      'Robot(name: $name, initialPosition: $initialPosition, links: $links)';
}
