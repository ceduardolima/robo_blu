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
  String toString() => '(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}, ${z.toStringAsFixed(2)})';
}
