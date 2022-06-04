import 'package:flutter_assignment2/components/offer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/pages/home_page.dart';
import 'package:flutter/material.dart';

//Class to test home page build
void main() {
  //Test that the title loads
  testWidgets('home page title loads', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: MyHomePage(),
      ),
    ));

    // Create the Finders.
    final textFinder = find.text('Offers near you');

    expect(textFinder, findsOneWidget);
  });
  //Test to check that the navigation bar loads
  testWidgets('home page nav bar loads', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: MyHomePage(),
      ),
    ));

    final navBarFav = find.widgetWithIcon(IconButton, Icons.favorite);
    final navBarHome = find.widgetWithIcon(IconButton, Icons.travel_explore);

    expect(navBarFav, findsOneWidget);
    expect(navBarHome, findsOneWidget);
  });
}
