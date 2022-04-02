import 'dart:ui';

import 'package:flutter/material.dart';
import 'globalVar.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';

class offerDetails extends StatefulWidget {
  List<String> offerDetailsList = [];

  offerDetails(this.offerDetailsList, {Key? key}) : super(key: key);

  @override
  State<offerDetails> createState() => _offerDetails(offerDetailsList);
}

class _offerDetails extends State<offerDetails> {
  List<String> offerDetailsList = [];
  String title = "default";
  // ignore: non_constant_identifier_names
  String best_before = "default";
  String distance = "default";
  //default image
  String image = "default";
  String city = "Deventer (default)"; //todo
  String description = "default";

  _offerDetails(List<String> offerDetailsList) {
    this.offerDetailsList = offerDetailsList;
    title = offerDetailsList.elementAt(3);
    best_before = offerDetailsList.elementAt(7);
    distance = "1.5 km"; // todo
    image = offerDetailsList.elementAt(5);
    description = offerDetailsList.elementAt(4);
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                image,
              ),
              Padding(
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
                  children: const [Icon(FontAwesome.map_pin)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
