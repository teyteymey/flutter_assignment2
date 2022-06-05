import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/pages/offer_details_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:image_test_utils/image_test_utils.dart'

//Class to test details page
void main() {
  testWidgets('Page back navigation loads', (tester) async {
    Map<String, dynamic> offer = {
      "id": "1",
      "category_id": "1",
      "user_id": "1",
      "title": "Half kg of avocados",
      "description": "Hello world! I come from global variables daaata",
      "image":
          "https://images.unsplash.com/photo-1593280443077-ae46e0100ad1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGJhbmFuYXxlbnwwfHwwfHw%3D&w=1000&q=80",
      "closed": false,
      "end_date": "23-03-2022",
      "created_at": "20-02-2022",
      "closed_at": null
    };
    provideMockedNetworkImages(() async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: OfferDetails(offer),
      ),
    ));
    }

    final textFinder = find.text('Back');

    expect(textFinder, findsOneWidget);
  });

  //Test to check that the navigation bar loads
  testWidgets(' nav bar loads', (tester) async {
    Map<String, dynamic> offer = {
      "id": "1",
      "category_id": "1",
      "user_id": "1",
      "title": "Half kg of avocados",
      "description": "Hello world! I come from global variables daaata",
      "image":
          "https://images.unsplash.com/photo-1593280443077-ae46e0100ad1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGJhbmFuYXxlbnwwfHwwfHw%3D&w=1000&q=80",
      "closed": false,
      "end_date": "23-03-2022",
      "created_at": "20-02-2022",
      "closed_at": null
    };
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: OfferDetails(offer),
      ),
    ));
  });
}
