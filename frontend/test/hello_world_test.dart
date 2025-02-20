import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Should display Hello World text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the "Hello World" text is found.
    expect(find.text('Hello World from Flutter Web!'), findsOneWidget);

    
  });
}
