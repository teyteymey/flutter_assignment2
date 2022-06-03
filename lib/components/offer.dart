import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/offer_details_page.dart';
import '../pages/offer_details_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global_var.dart' as globals;

// Returns all the objects offered in a certain area formatted as cards
class Offer extends StatelessWidget {
  String id = "-1";
  String categoryId = "-1";
  String userId = "-1";
  String title = "default";
  String description = "default";
  String image = "default";
  bool closed = false;
  String endDate = "20-02-2022";
  String createdAt = "20-02-2022";
  String closedAt = "20-02-2022";
  String distance = "default";

  Map<String, dynamic> offerDetailsMap = {};

  // // constructor method, sets all the attributes
  // Offer.fromMap(Map<String, dynamic> offerDetails, {Key? key})
  //     : super(key: key) {
  //   offerDetailsMap = offerDetails;
  //   title = offerDetails["title"];
  //   endDate = offerDetails["end_date"];
  //   distance = "1.5 km"; // todo
  //   image = offerDetails["image"];
  // }

  Offer({
    Key? key,
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.closed,
    required this.endDate,
    required this.createdAt,
    required this.closedAt,
  }) : super(key: key);

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
        id: json['id'],
        categoryId: json['category_id'],
        userId: json['user_id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        closed: json['closed'],
        endDate: json['end_date'],
        createdAt: json['created_at'],
        closedAt: json['closed_at']);
  }

  @override
  // the container of a card: it is a text button showing image, distance and best before date
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OfferDetails(offerDetailsMap)),
        );
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  image,
                )),
            ListTile(
              title: Text(title,
                  style: const TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  )),
              subtitle: Text(distance + "       Best before: " + endDate,
                  style: const TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> getPictureOfferById(String id) async {
  final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/offer/' + id + '/'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + globals.accessToken,
      });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['image'];
  } else {
    throw Exception('Failed to offer.');
  }
}
