import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/favorites_page.dart';
import 'package:flutter_assignment2/pages/messages_page.dart';
import 'package:flutter_assignment2/pages/my_offers_page.dart';
import 'package:flutter_assignment2/pages/profile_page.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import '../components/offer.dart';
import '../global_var.dart' as globals;
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Offers near you');
  List<Map<String, dynamic>> offers = [];

  void getOffers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/offers'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + globals.accessToken,
        });

    if (response.statusCode == 200) {
      offers = jsonDecode(response.body);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            // Retrieve the text that the user has entered by using the
            // TextEditingController.
            content: const Text("Failed to get offers."),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: customSearchBar,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = const ListTile(
                      leading: Icon(
                        Icons.search,
                        color: const Color(0xFF2A8600),
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'search for specific word',
                          hintStyle: TextStyle(
                            color: Color(0xFF2A8600),
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: const Color(0xFF2A8600),
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('My Personal Journal');
                  }
                });
              },
              icon: customIcon,
            )
          ],
          centerTitle: true,
          // title: const Text(
          //   'Offers near you',
          //   textAlign: TextAlign.center,
          // ),
          backgroundColor: const Color(0xFFF4F2DD),
        ),
        //backgroundColor: const Color(0xFFF4F2DD),
        body: SingleChildScrollView(
          // to avoid overfloww
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              for (var offer in offers) Offer.fromMap(offer)
            ], // for each offer, we create and display a card
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFF9F9F9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  //explore button
                  child: IconButton(
                icon: const Icon(
                  Icons.travel_explore,
                  color: const Color(0xFF2A8600),
                ),
                onPressed: () {},
              )),
              Expanded(
                  //favorite items
                  child: IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavoritesPage()),
                        );
                      })),
              Expanded(
                //my offers
                child: IconButton(
                    icon: const Icon(FontAwesome.food),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyOffers()),
                      );
                    }),
              ),
              Expanded(
                  //messages
                  child: IconButton(
                      icon: const Icon(Icons.mail),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MessagesPage()),
                        );
                      })),
              Expanded(
                  //my profile
                  child: IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
