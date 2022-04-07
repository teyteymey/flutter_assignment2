import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/myOffers.dart';
import 'package:flutter_assignment2/offerDetails.dart';
import 'package:flutter_assignment2/profilePage.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'Offer.dart';
import 'globalVar.dart' as globals;
import 'offerDetails.dart';
import 'offerDetails.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Offers near you',
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
              for (var i in globals.allOffers) Offer(i)
            ], // for each offer, we create and display a card
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  //explore button
                  child: IconButton(
                icon: const Icon(Icons.travel_explore),
                onPressed: () {},
              )),
              Expanded(
                  //favorite items
                  child: IconButton(
                      icon: const Icon(Icons.favorite), onPressed: () {})),
              Expanded(
                //my offers
                child: IconButton(
                    icon: const Icon(FontAwesome.food),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => myOffers()),
                      );
                    }),
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
