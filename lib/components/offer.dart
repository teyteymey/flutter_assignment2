import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/offer_details_page.dart';
import '../pages/offer_details_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global_var.dart' as globals;

// Class Offer. It has two constructors and a build method so the same style is applyied
// in all the application
class Offer extends StatelessWidget {
  var id = "-1";
  var categoryId = "-1";
  var userId = "-1";
  var title = "default";
  var description = "default";
  var image = "default";
  var closed = "false";
  var endDate = "20-02-2022";
  var createdAt = "20-02-2022";
  var closedAt = "20-02-2022";
  var distance = "default";

  // String id = "-1";
  // String categoryId = "-1";
  // String userId = "-1";
  // String title = "default";
  // String description = "default";
  // String image = "default";
  // bool closed = false;
  // String endDate = "20-02-2022";
  // String createdAt = "20-02-2022";
  // String closedAt = "20-02-2022";
  // String distance = "default";
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

  factory Offer.fromJson(Map<dynamic, dynamic> json) {
    return Offer(
        id: json['id'].toString(),
        categoryId: json['category_id'].toString(),
        userId: json['user_id'].toString(),
        title: json['title'].toString(),
        description: json['description'].toString(),
        image: json['image'].toString(),
        closed: json['closed'].toString(),
        endDate: json['end_date'].toString(),
        createdAt: json['created_at'].toString(),
        closedAt: json['closed_at'].toString());
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
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(15.0),
            //     child: Image.network(
            //       'http:/' + image,
            //     )),
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

// Call to the API to get the picture of the offer by providing its ID
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
