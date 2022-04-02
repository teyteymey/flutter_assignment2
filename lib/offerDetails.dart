import 'dart:ui';

import 'package:flutter/material.dart';
import 'globalVar.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class offerDetails extends StatefulWidget {
  List<String> offerDetailsList = [];

  offerDetails(this.offerDetailsList, {Key? key}) : super(key: key);

  @override
  State<offerDetails> createState() => _offerDetails(offerDetailsList);
}

// this class builds the details of a certain offer
class _offerDetails extends State<offerDetails> {
  // ATTRIBUTES
  List<String> offerDetailsList = [];
  String title = "default";
  // ignore: non_constant_identifier_names
  String best_before = "default";
  String distance = "default";
  //default image
  String image = "default";
  String city = "default"; //todo
  String description = "default";

  // BUILDER METHOD
  // we set the attributes of the offer
  _offerDetails(List<String> offerDetailsList) {
    this.offerDetailsList = offerDetailsList;
    title = offerDetailsList.elementAt(3);
    best_before = offerDetailsList.elementAt(7);
    distance = "1.5 km"; // todo
    this.city = "Deventer"; //todo
    image = offerDetailsList.elementAt(5);
    description = offerDetailsList.elementAt(4);
  }

  void reserve() {}

  //displays all the information of the offer
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
          child: SizedBox(
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF7F9946)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))),
              onPressed: () => reserve(),
              child: Text(
                "Reserve",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(FontAwesome.angle_left),
            onPressed: () => Navigator.pop(context, false),
          ), // different arroy style to fit with the prototype
          title: const Text(
            'Back',
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFF4F2DD),
        ),
        //backgroundColor: const Color(0xFFF4F2DD),
        body: SingleChildScrollView(
          // to avoid overfloww
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
                CrossAxisAlignment.start, // so the text starts at the left
            children: <Widget>[
              Image.network(
                //image
                //first we load the image
                image,
              ),
              Padding(
                // title
                //some space between the image and the title
                padding: const EdgeInsets.all(15.0),
                child: Text(title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                    )),
              ),
              Padding(
                // location
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesome.map_pin,
                      size: 15,
                    ),
                    Text("   " +
                        city +
                        "    "), // putting some distance between the icon and the location
                    Text(
                      "(" + distance + ")",
                      style: const TextStyle(
                          fontFamily: 'JosefinSans', color: Colors.grey),
                    )
                  ],
                ),
              ),
              Padding(
                // date best before
                padding: const EdgeInsets.only(left: 15.0, top: 7),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesome.calendar,
                      size: 15,
                    ),
                    Text("   " +
                        best_before +
                        "    "), // putting some distance between the icon and the location
                    const Text(
                      "(best before)",
                      style: TextStyle(
                          fontFamily: 'JosefinSans', color: Colors.grey),
                    )
                  ],
                ),
              ),
              const Padding(
                //divider
                // divider of the text (grey line)
                padding:
                    EdgeInsets.only(top: 8.0, left: 15, right: 15, bottom: 8.0),
                child: Divider(
                  thickness: 1.5,
                ),
              ),
              Padding(
                //description of the product
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
