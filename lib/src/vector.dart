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

  Vector clipped(Vector origin) {
    final dirX = Vector.unitX.dot(normalized());
    final dirY = Vector.unitY.dot(normalized());

    final lx = dirX >= 0 ? 1 : -1;
    final ly = dirY >= 0 ? 1 : -1;
    final t1 = (lx - origin.x) / x;
    final t2 = (ly - origin.y) / y;
    if (t1.abs() < t2.abs()) {
      return origin + this * t1;
    } else {
      return origin + this * t2;
    }
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
