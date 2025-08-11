// This is a basic Flutter widget test for JOTM Radio app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jotm_radio/main.dart';

void main() {
  testWidgets('JOTM Radio app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the app to initialize
    await tester.pumpAndSettle();

    // Verify that our app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // Verify that the app has some basic structure
    expect(find.byType(Scaffold), findsOneWidget);
    
    // Test passes if app loads without errors
    expect(true, isTrue);
  });
}
