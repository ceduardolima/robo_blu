import 'package:r_link/domain/links/link.dart';
import 'package:r_link/domain/links/r_link.dart';
import 'package:r_link/domain/robot/robot.dart';
import 'package:r_link/domain/utils/bound.dart';
final List<Link> links = [
  RLink(d: 2.5, a: 0, alpha: -90, bound: Bound(lower: 0, upper: 180)),
  RLink(d: 0, a: 8.5, alpha: 0, bound: Bound(lower: 10, upper: 45)),
  RLink(d: 0, a: 8.5, alpha: 90, bound: Bound(lower: 0, upper: 50)),
];

final Robot robot =
    Robot(name: "Robo 1", initialPosition: [80, 45, 45], links: links);

