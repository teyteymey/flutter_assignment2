import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/pages/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

//test to check favorites page
void main() {
  testWidgets('favorites page test has searchbar', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FavoritesPage(),
      ),
    ));
    ;

    // Create the Finders.
    final searchBarFinder = find.text('Favorite offers');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(searchBarFinder, findsOneWidget);
  });

  // Test that the searchbar is loaded correctly
  testWidgets('favorites page loads navigation bar', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FavoritesPage(),
      ),
    ));
    ;

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
