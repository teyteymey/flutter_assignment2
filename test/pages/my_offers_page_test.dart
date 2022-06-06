import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/pages/my_offers_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

//Class to test my offers page
// RM8: see own posted offers
void main() {
  testWidgets('Page title loads', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: MyOffers(),
      ),
    ));

    final textFinder = find.text('Your offers');

    expect(textFinder, findsOneWidget);
  });

  //Test to check that the navigation bar loads
  testWidgets(' nav bar loads', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: MyOffers(),
      ),
    ));

    final navBarFav = find.widgetWithIcon(IconButton, Icons.favorite);
    final navBarHome = find.widgetWithIcon(IconButton, Icons.travel_explore);
    final navMyOffers = find.widgetWithIcon(IconButton, FontAwesome.food);
    final navMessages = find.widgetWithIcon(IconButton, Icons.mail);
    final navProfile = find.widgetWithIcon(IconButton, Icons.person);

    expect(navBarFav, findsOneWidget);
    expect(navBarHome, findsOneWidget);
    expect(navMyOffers, findsOneWidget);
    expect(navMessages, findsOneWidget);
    expect(navProfile, findsOneWidget);
  });
}
