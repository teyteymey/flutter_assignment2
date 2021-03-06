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

// Page that shows the favorite offers of a user
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Widget customSearchBar = const Text('Favorite offers');
  List<Offer> favoriteOffers = [];

  @override
  void initState() {
    getFavoriteOffers().then((value) {
      print('Async done');
    });
    super.initState();
  }

  _FavoritesPageState() {}

  // Calls the API and gets a lost of the favorite offers of the user
  Future getFavoriteOffers() async {
    var headers = {
      'Authorization': 'Bearer ' + globals.accessToken,
    };
    var request = http.Request(
        'GET', Uri.parse('http://10.0.2.2:8000/user/favorite_offers'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Iterable l = json.decode(await response.stream.bytesToString());
      favoriteOffers =
          List<Offer>.from(l.map((model) => Offer.fromJson(model)));
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
            content: const Text("Failed to get favorite offers."),
          );
        },
      );
    }

    //THIS WAY WAS NOT WORKING FOR SOME REASON
    // final response = await http.get(
    //     Uri.parse('http://10.0.2.2:8000/user/favorite_offers/'),
    //     headers: <String, String>{
    //       'Authorization': 'Bearer ' + globals.accessToken,
    //     });

    // print(response.body);

    // if (response.statusCode == 200) {
    //   Iterable l = json.decode(response.body);
    //   favoriteOffers =
    //       List<Offer>.from(l.map((model) => Offer.fromJson(model)));
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
    //         content: const Text("Failed to get favorite offers."),
    //       );
    //     },
    //   );
    // }
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
          backgroundColor: const Color(0xFFF4F2DD),
        ),
        //backgroundColor: const Color(0xFFF4F2DD),
        body: SingleChildScrollView(
          // to avoid overfloww
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              for (var i in favoriteOffers) i.build(context)
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
