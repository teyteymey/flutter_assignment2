import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/favorites_page.dart';
import 'package:flutter_assignment2/pages/home_page.dart';
import 'package:flutter_assignment2/pages/messages_page.dart';
import 'package:flutter_assignment2/pages/post_offer_page.dart';
import 'package:flutter_assignment2/pages/profile_page.dart';
import '../components/offer.dart';
import '../global_var.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyOffers extends StatefulWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  State<MyOffers> createState() => _MyOffers();
}

// this class builds the details of a certain offer
class _MyOffers extends State<MyOffers> {
  //Atributes
  Map<String, dynamic> userDetails = {};
  List<Offer> offers = [];

  @override
  void initState() {
    getMyOffers().then((value) {
      print('Async done');
    });
    super.initState();
  }

  _MyOffers() {}

  //Calls the API and get the offers posted by the user and saves them in the variable myOffers
  Future getMyOffers() async {
    var headers = {
      'Authorization': 'Bearer ' + globals.accessToken,
    };
    var request =
        http.Request('GET', Uri.parse('http://10.0.2.2:8000/user/offers'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Iterable l = json.decode(await response.stream.bytesToString());
      offers = List<Offer>.from(l.map((model) => Offer.fromJson(model)));
      setState(() {});
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
            content: const Text("Failed to get user offers."),
          );
        },
      );
    }

    // final response = await http.get(
    //     Uri.parse('http://10.0.2.2:8000/user/offers/'),
    //     headers: <String, String>{
    //       'Authorization': 'Bearer ' + globals.accessToken,
    //     });

    // if (response.statusCode == 200) {
    //   Iterable l = json.decode(response.body);
    //   offers = List<Offer>.from(l.map((model) => Offer.fromJson(model)));
    //   setState(() {});
    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(15.0)), //make alert rounded
    //         backgroundColor: const Color.fromARGB(237, 244, 242, 221),
    //         // Retrieve the text that the user has entered by using the
    //         // TextEditingController.
    //         content: const Text("Failed to get user offers."),
    //       );
    //     },
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
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
              for (var i in offers) i.build(context)
            ], // for each offer, we create and display a card
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 42, 134, 0),
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostOffer()),
            );
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFF9F9F9),
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
                    icon: const Icon(FontAwesome.food,
                        color: const Color(0xFF2A8600)),
                    onPressed: () {}), //in this case do nothing bc we are here
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
