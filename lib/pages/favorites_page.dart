import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/messages_page.dart';
import 'package:flutter_assignment2/pages/my_offers_page.dart';
import 'package:flutter_assignment2/pages/profile_page.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'home_page.dart';
import '../components/offer.dart';
import '../global_var.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

// I cant implement the method to add favorites because I need the api for that.
class _FavoritesPageState extends State<FavoritesPage> {
  Widget customSearchBar = const Text('Favorite offers');
  List<Map<String, dynamic>> favoriteOffers = [];

  void getFavoriteOffers() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000//user/favorite_offers/'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + globals.accessToken,
        });

    if (response.statusCode == 200) {
      favoriteOffers = jsonDecode(response.body);
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
            content: const Text("Failed to get favorite offers."),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: customSearchBar,

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
              for (var i in favoriteOffers) Offer.fromMap(i)
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
                      icon: const Icon(Icons.favorite,
                          color: const Color(0xFF2A8600)),
                      onPressed: () {})),
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
