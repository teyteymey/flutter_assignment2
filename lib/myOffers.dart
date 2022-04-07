import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/homePage.dart';
import 'package:flutter_assignment2/profilePage.dart';
import 'Offer.dart';
import 'globalVar.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter/cupertino.dart';

class myOffers extends StatefulWidget {
  myOffers({Key? key}) : super(key: key);

  @override
  State<myOffers> createState() => _myOffers();
}

// this class builds the details of a certain offer
class _myOffers extends State<myOffers> {
  //Atributes
  Map<String, dynamic> userDetails = {};

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Your offers',
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFF4F2DD),
        ),
        //backgroundColor: const Color(0xFFF4F2DD),
        body: SingleChildScrollView(
          // to avoid overfloww
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              for (var i in globals.myoffers) Offer.fromMap(i)
            ], // for each offer, we create and display a card
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  //explore page
                  child: IconButton(
                icon: const Icon(Icons.travel_explore),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
              )),
              Expanded(
                  //favorite items
                  child: IconButton(
                      icon: const Icon(Icons.favorite), onPressed: () {})),
              Expanded(
                //my offers
                child: IconButton(
                    icon: const Icon(FontAwesome.food),
                    onPressed: () {}), //in this case do nothing bc we are here
              ),
              Expanded(
                  //messages
                  child: IconButton(
                      icon: const Icon(Icons.mail), onPressed: () {})),
              Expanded(
                  //my profile
                  child: IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => profilePage()),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
