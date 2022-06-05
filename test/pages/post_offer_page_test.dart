import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/pages/post_offer_page.dart';
import 'package:flutter/material.dart';
import 'package:network_image_mock/network_image_mock.dart';

//Class to test the page to add a new offer
void main() {
  //Test that the form loads correctly
  testWidgets('Form loads', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: PostOffer(),
        ),
      ),
    );

    final name = find.widgetWithText(TextFormField, 'Name');
    final bestBefore = find.widgetWithText(TextFormField, 'Best before');
    final description = find.widgetWithText(TextFormField, 'Description');

    expect(name, findsOneWidget);
    expect(bestBefore, findsOneWidget);
    expect(description, findsOneWidget);
  });

  // Test that the button appears correctly
  testWidgets('Button to post is correct', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: PostOffer(),
        ),
      ),
    );

    final name = find.widgetWithText(ElevatedButton, 'Post offer');

    expect(name, findsOneWidget);
  });

  //Test that error message is expected
  testWidgets('Tapping button with empty fields shows correct error',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: PostOffer(),
        ),
      ),
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Post offer'));
    await tester.pump();
    expect(find.text("Please fill all the required fields"), findsOneWidget);
  });
}
