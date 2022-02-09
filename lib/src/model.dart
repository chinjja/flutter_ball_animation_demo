import 'dart:math';

import 'package:ball_demo/src/vector.dart';
import 'package:flutter/material.dart';

class Ball {
  static final rand = Random();

  late Alignment target;
  Alignment current;
  final double radius;
  final Color color;
  Vector vector;
  late Vector _distance;

  Ball({
    required this.current,
    required this.radius,
    required this.color,
    required this.vector,
  }) {
    _update();
  }

  double duration(Size size) {
    final offset = target - current;
    final d = Offset(
      size.width * offset.x,
      size.height * offset.y,
    );
    return d.distance / vector.norm();
  }

  factory Ball.random() {
    return Ball(
      color: Color.fromRGBO(
        rand.nextInt(256),
        rand.nextInt(256),
        rand.nextInt(256),
        0.5,
      ),
      radius: rand.nextInt(50) + 25,
      current: Alignment(
        rand.nextDouble() * 2 - 1,
        rand.nextDouble() * 2 - 1,
      ),
      vector: _randomVector(),
    );
  }

  void bouncing() {
    if (target.y.abs() > 0.95) {
      vector = Vector.unitY.reflect(vector);
    } else {
      vector = Vector.unitX.reflect(vector);
    }
    _update();
    while (_distance.dot(_distance) < 0.01) {
      vector = _randomVector();
      _update();
    }
  }

  static Vector _randomVector() {
    var dx = rand.nextDouble() * 2 - 1;
    var dy = rand.nextDouble() * 2 - 1;
    if (dx.abs() < 0.1) {
      if (dx >= 0) {
        dx = 0.1;
      } else {
        dx = -0.1;
      }
    }
    if (dy.abs() < 0.1) {
      if (dy >= 0) {
        dy = 0.1;
      } else {
        dy = -0.1;
      }
    }
    return Vector(dx, dy);
  }

  void _update() {
    final clipped = _clipped(current.toVector());
    target = Alignment(clipped.x, clipped.y);

    _distance = (current - target).toVector();
  }

  Vector _clipped(Vector origin) {
    final n = vector.normalized();
    final dirX = Vector.unitX.dot(n);
    final dirY = Vector.unitY.dot(n);

    final lx = dirX >= 0 ? 1 : -1;
    final ly = dirY >= 0 ? 1 : -1;
    final t1 = (lx - origin.x) / vector.x;
    final t2 = (ly - origin.y) / vector.y;
    if (t1.abs() < t2.abs()) {
      return origin + vector * t1;
    } else {
      return origin + vector * t2;
    }
  }
}
