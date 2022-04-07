import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/myOffers.dart';
import 'package:flutter_assignment2/offerDetails.dart';
import 'package:flutter_assignment2/profilePage.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'globalVar.dart' as globals;
import 'offerDetails.dart';
import 'offerDetails.dart';

// Returns all the objects offered in a certain area formatted as cards
class Offer extends StatelessWidget {
  int id = -1;
  int category_id = -1;
  int user_id = -1;
  String title = "default";
  String description = "default";
  String image = "default";
  bool closed = false;
  String end_date = "20-02-2022";
  String created_at = "20-02-2022";
  String closed_at = "20-02-2022";
  String distance = "default";

  Map<String, dynamic> offerDetailsMap = {};

  // constructor method, sets all the attributes
  Offer.fromMap(Map<String, dynamic> offerDetails, {Key? key})
      : super(key: key) {
    offerDetailsMap = offerDetails;
    title = offerDetails["title"];
    end_date = offerDetails["end_date"];
    distance = "1.5 km"; // todo
    image = offerDetails["image"];
  }

  Offer({
    Key? key,
    required this.id,
    required this.category_id,
    required this.user_id,
    required this.title,
    required this.description,
    required this.image,
    required this.closed,
    required this.end_date,
    required this.created_at,
    required this.closed_at,
  }) : super(key: key);

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
        id: json['id'],
        category_id: json['category_id'],
        user_id: json['user_id'],
        title: json['userId'],
        description: json['description'],
        image: json['image'],
        closed: json['closed'],
        end_date: json['end_date'],
        created_at: json['created_at'],
        closed_at: json['closed_at']);
  }

  @override
  // the container of a card: it is a text button showing image, distance and best before date
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => offerDetails(offerDetailsMap)),
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
              subtitle: Text(distance + "       Best before: " + end_date,
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
