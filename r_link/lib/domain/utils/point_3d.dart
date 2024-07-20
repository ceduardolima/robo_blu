// ignore_for_file: public_member_api_docs, sort_constructors_first
class Point3D {
  final double x;
  final double y;
  final double z;

  Point3D(
    this.x,
    this.y,
    this.z,
  );

  @override
  String toString() => 'Point3D(x: $x, y: $y, z: $z)';
}
