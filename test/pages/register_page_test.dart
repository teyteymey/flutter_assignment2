import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/pages/register_page.dart';
import 'package:flutter/material.dart';

//Class to test the register page
void main() {
  //Test that the logo loads
  testWidgets('register page shows image', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: RegisterPage(),
      ),
    ));

    final imageFinder =
        find.image(const AssetImage("images/appvocado-loading.png"));

    expect(imageFinder, findsOneWidget);
  });

  //Test the form is displayed correctly
  testWidgets('register page renders forms', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: RegisterPage(),
      ),
    ));

    // Create the Finders.
    final username = find.widgetWithText(TextFormField, 'Username');
    final password = find.widgetWithText(TextFormField, 'Password');
    final password2 = find.widgetWithText(TextFormField, 'Repeat password');

    expect(username, findsOneWidget);
    expect(password, findsOneWidget);
    expect(password2, findsOneWidget);
  });

  //Test the button to sign up loads
  testWidgets('register page renders button to sign up', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: RegisterPage(),
      ),
    ));

    // Create the Finders.
    final buttonFinder = find.widgetWithText(ElevatedButton, 'Create account');

    expect(buttonFinder, findsOneWidget);
  });

  //Test that error message is expected
  testWidgets('Tapping button with empty fields shows correct error',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: RegisterPage(),
        ),
      ),
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Create account'));
    await tester.pump();
    expect(find.text("Fill all the required fields"), findsOneWidget);
  });
}
