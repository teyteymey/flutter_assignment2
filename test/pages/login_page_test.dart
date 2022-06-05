import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/pages/login_page.dart';
import 'package:flutter/material.dart';

//Class to test the login page
void main() {
  //Test that the image in login loads
  testWidgets('login shows image', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: LoginPage(),
      ),
    ));

    // Create the Finders.
    final imageFinder =
        find.image(const AssetImage("images/appvocado-loading.png"));

    expect(imageFinder, findsOneWidget);
  });

  //Test the form is displayed correctly
  testWidgets('login renders forms', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: LoginPage(),
      ),
    ));

    // Create the Finders.
    final username = find.widgetWithText(TextFormField, 'Username');
    final password = find.widgetWithText(TextFormField, 'Password');

    expect(username, findsOneWidget);
    expect(password, findsOneWidget);
  });

  //Test the button to sign up loads
  testWidgets('login renders button to sign up', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: LoginPage(),
      ),
    ));

    // Create the Finders.
    final buttonFinder = find.widgetWithText(TextButton, 'Sign up');

    expect(buttonFinder, findsOneWidget);
  });
}
