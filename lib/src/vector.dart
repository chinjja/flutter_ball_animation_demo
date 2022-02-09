import 'dart:math';

import 'package:flutter/material.dart';

class Vector {
  final double x;
  final double y;

  static const zero = Vector(0, 0);
  static const unitX = Vector(1, 0);
  static const unitY = Vector(0, 1);

  const Vector(this.x, this.y);

  double dot(Vector v) {
    return x * v.x + y * v.y;
  }

  double norm() {
    return sqrt(dot(this)).abs();
  }

  Vector operator *(double s) {
    return Vector(x * s, y * s);
  }

  Vector operator -() {
    return Vector(-x, -y);
  }

  Vector operator +(Vector v) {
    return Vector(x + v.x, y + v.y);
  }

  Vector operator -(Vector v) {
    return Vector(x - v.x, y - v.y);
  }

  Vector normalized() {
    final s = norm();
    return Vector(x / s, y / s);
  }

  Vector reflect(Vector v) {
    final a = this * dot(v);
    final b = v - a;
    return b - a;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode & y.hashCode;

  @override
  String toString() => '($x, $y)';
}

extension AlignmentNormalized on Alignment {
  Vector toVector() {
    return Vector(x, y);
  }
}
