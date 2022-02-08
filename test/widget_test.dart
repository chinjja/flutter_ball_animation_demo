import 'package:ball_demo/src/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('when startup is completed, it should have one', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(BallWidget), findsOneWidget);
  });

  testWidgets('when clear, all items should be deleted', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
    expect(find.byType(BallWidget), findsNothing);
  });

  testWidgets('when add button is pressed, new item is added', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.byType(BallWidget), findsNWidgets(2));
  });
}
