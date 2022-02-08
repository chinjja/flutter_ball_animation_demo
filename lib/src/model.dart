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
  late double _distance;
  late double _velocity;

  Ball({
    required this.current,
    required this.radius,
    required this.color,
    required this.vector,
  }) {
    _update();
  }

  double get distance => _distance;
  double get velocity => _velocity;

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
      vector: Vector(
        (rand.nextDouble() - 0.5) * 0.1,
        (rand.nextDouble() - 0.5) * 0.1,
      ),
    );
  }

  void bouncing() {
    if (target.y.abs() > 0.95) {
      vector = Vector.unitY.reflect(vector);
    } else {
      vector = Vector.unitX.reflect(vector);
    }
    _update();
    while (distance < 0.01) {
      vector = Vector(
        (rand.nextDouble() - 0.5) * 0.1,
        (rand.nextDouble() - 0.5) * 0.1,
      );
      _update();
    }
  }

  void _update() {
    final clipped = vector.clipped(current.toVector());
    target = Alignment(clipped.x, clipped.y);

    _distance = (current - target).toVector().norm();
    _velocity = _distance + rand.nextDouble();
  }
}
