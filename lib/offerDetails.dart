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

  //displays all the information of the offer
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Back',
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(21, 124, 124, 117),
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
                //first we load the image
                image,
              ),
              Padding(
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
                // divider of the text (grey line)
                padding: EdgeInsets.only(top: 8.0, left: 15, right: 15),
                child: Divider(
                  thickness: 1.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
