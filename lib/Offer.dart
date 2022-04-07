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
  String title = "default";
  // ignore: non_constant_identifier_names
  String best_before = "default";
  String distance = "default";
  //default image
  String image = "default";
  Map<String, dynamic> offerDetailsMap = {};

  // constructor method, sets all the attributes
  Offer(Map<String, dynamic> offerDetails, {Key? key}) : super(key: key) {
    this.offerDetailsMap = offerDetails;
    title = offerDetails["title"];
    best_before = offerDetails["end_date"];
    distance = "1.5 km"; // todo
    image = offerDetails["image"];
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
              subtitle: Text(distance + "       Best before: " + best_before,
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
