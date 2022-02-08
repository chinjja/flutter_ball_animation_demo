import 'package:ball_demo/src/vector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('vector equality', () {
    final v = Vector(1, 2);
    expect(v, Vector(1, 2));
  });

  test('vector scalar multiply', () {
    final v = Vector(1, 2) * 5;
    expect(v, Vector(5, 10));
  });

  test('vector operator +', () {
    final v = Vector(1, 2) + Vector(5, 5);
    expect(v, Vector(6, 7));
  });

  test('vector operator unitary -', () {
    final v = -Vector(1, 2);
    expect(v, Vector(-1, -2));
  });

  test('vector dot', () {
    final v = Vector(2, 3).dot(Vector(3, 3));
    expect(v, 6 + 9);
  });

  test('vector norm', () {
    final v = Vector(0, 2);
    expect(v.norm(), 2);
  });

  test('vector projection', () {
    final v1 = Vector(1, 2);
    expect(Vector.unitX.dot(v1), 1);
    expect(Vector.unitY.dot(v1), 2);

    final v2 = Vector(-1, -2);
    expect(Vector.unitX.dot(v2), -1);
    expect(Vector.unitY.dot(v2), -2);
  });

  test('vector normalized', () {
    final v = Vector(1, 1).normalized();
    expect(v.norm(), moreOrLessEquals(1));
  });

  test('vector reflect', () {
    final normal = Vector(0, 1).normalized();
    expect(normal.reflect(Vector(2, -2)), Vector(2, 2));
  });
}
