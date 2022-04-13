import 'package:flutter/material.dart';
import 'package:flutter_assignment2/home_page.dart';
import 'package:flutter_assignment2/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  testWidgets('Login correctly', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(const LoginPage());

    // Enter 'hi' into the TextField.
    expect(find.byWidget(TextFormField()), findsNWidgets(2));
    await tester.enterText(find.bySemanticsLabel("Username"), 'John');
    await tester.enterText(find.bySemanticsLabel("Passeord"), 'John');

    // Tap the add button.
    await tester.tap(find.byType(ElevatedButton));

    // Rebuild the widget with the new item.
    await tester.pump();

    // Ensure that the item is no longer on screen.
    expect(find.byWidget(MyHomePage()), findsOneWidget);
  });
}
