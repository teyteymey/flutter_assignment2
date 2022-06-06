import 'package:flutter_assignment2/components/offer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment2/pages/offer_details_page.dart';
import 'package:flutter/material.dart';
import 'package:network_image_mock/network_image_mock.dart';

//Class to test details page
void main() {
  testWidgets('Page back navigation loads', (tester) async {
    final Map<String, dynamic> myoffer = {
      "id": "2",
      "category_id": "1",
      "user_id": "1",
      "title": "Half kg of lemons",
      "description": "Hello world!",
      "image":
          "https://post.healthline.com/wp-content/uploads/2020/09/lemon-health-benefits-1200x628-facebook-1200x628.jpg",
      "closed": false,
      "end_date": "23-03-2022",
      "created_at": "20-02-2022",
      "closed_at": "20-02-2022"
    };
    Offer offer = Offer.fromJson(myoffer);

    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: OfferDetails(offer),
            ),
          ),
        ));

    final textFinder = find.text('Back');

    expect(textFinder, findsOneWidget);
  });

  //Test to check that the button is correct
  testWidgets('button is showed', (tester) async {
    final Map<String, dynamic> myoffer = {
      "id": "2",
      "category_id": "1",
      "user_id": "1",
      "title": "Half kg of lemons",
      "description": "Hello world!",
      "image":
          "https://post.healthline.com/wp-content/uploads/2020/09/lemon-health-benefits-1200x628-facebook-1200x628.jpg",
      "closed": false,
      "end_date": "23-03-2022",
      "created_at": "20-02-2022",
      "closed_at": "20-02-2022"
    };
    Offer offer = Offer.fromJson(myoffer);
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: OfferDetails(offer),
            ),
          ),
        ));

    final textFinder = find.text('Reserve');

    expect(textFinder, findsOneWidget);
  });

  //Test to check that the information showed is correct
  testWidgets('information is correct', (tester) async {
    final Map<String, dynamic> myoffer = {
      "id": "2",
      "category_id": "1",
      "user_id": "1",
      "title": "Half kg of lemons",
      "description": "Hello world!",
      "image":
          "https://post.healthline.com/wp-content/uploads/2020/09/lemon-health-benefits-1200x628-facebook-1200x628.jpg",
      "closed": false,
      "end_date": "23-03-2022",
      "created_at": "20-02-2022",
      "closed_at": "20-02-2022"
    };
    Offer offer = Offer.fromJson(myoffer);
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: OfferDetails(offer),
            ),
          ),
        ));

    final textFinder = find.text('Half kg of lemons');
    final textFinder2 = find.text('Hello world!');

    expect(textFinder, findsOneWidget);
    expect(textFinder2, findsOneWidget);
  });
}
