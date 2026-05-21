import 'package:birdle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('short guesses show feedback and do not advance the board', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());

    await tester.enterText(find.byType(TextField), 'bird');
    await tester.tap(find.byIcon(Icons.arrow_circle_up));
    await tester.pump();

    expect(find.text('Enter a 5-letter word.'), findsOneWidget);
    expect(find.text('B'), findsNothing);
    expect(find.widgetWithText(TextField, 'bird'), findsOneWidget);
  });

  testWidgets('words outside the legal guess list show feedback', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());

    await tester.enterText(find.byType(TextField), 'crane');
    await tester.tap(find.byIcon(Icons.arrow_circle_up));
    await tester.pump();

    expect(find.text('Not in word list.'), findsOneWidget);
    expect(find.text('C'), findsNothing);
    expect(find.widgetWithText(TextField, 'crane'), findsOneWidget);
  });

  testWidgets('legal guesses advance the board and clear the input', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());

    await tester.enterText(find.byType(TextField), 'aback');
    await tester.tap(find.byIcon(Icons.arrow_circle_up));
    await tester.pump();

    expect(find.text('A'), findsNWidgets(2));
    expect(find.text('B'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
    expect(find.text('K'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'aback'), findsNothing);
  });
}
