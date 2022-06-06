import 'package:flutter/material.dart';
import 'package:flutter_assignment2/components/user.dart';
import 'package:flutter_assignment2/pages/favorites_page.dart';
import 'package:flutter_assignment2/pages/home_page.dart';
import 'package:flutter_assignment2/components/message.dart';
import 'package:flutter_assignment2/pages/my_offers_page.dart';
import 'package:flutter_assignment2/pages/profile_page.dart';
import '../components/offer.dart';
import '../global_var.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPage();
}

// this class builds the details of a certain offer
class _MessagesPage extends State<MessagesPage> {
  //Atributes
  List<Map<String, String>> myMessages = [];

  _MessagesPage() {
    getMessages();
  }

  // API to get the messages of the logged in user
  // Then they are rendered using Message class
  void getMessages() async {
    var request =
        http.Request('GET', Uri.parse('http://10.0.2.2:8000/user/requests'));
    var headers = <String, String>{
      'Authorization': 'Bearer ' + globals.accessToken,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Iterable l = json.decode(await response.stream.bytesToString());

      String name;
      String imageOffer;
      String imageUser =
          'https://cdn.psychologytoday.com/sites/default/files/styles/article-inline-half-caption/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=0hb44OrI';
      for (var message in l) {
        name = await getNameUserById(message['user_id'].toString());
        print(message);
        //AGAIN: LOADING PICS FROM BACKEND IS NEAR IMPOSSIBLE SO I WILL ASSIGN A DEFAULT ONE
        //imageOffer = await getPictureOfferById(message['offer_id'].toString());
        imageOffer =
            'https://www.boodschappen.nl/app/uploads/2018/09/Header_iStock-537514836-780x520.jpg';
        Map<String, String> aux = {};
        aux["id"] = message["id"].toString();
        aux["offerId"] = message['offer_id'].toString();
        aux["solicitorName"] = name;
        aux["imageOfSolicitor"] = imageUser;
        aux["imageOfOffer"] = imageOffer;

        myMessages.add(aux);
        setState(() {});
      }
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
            content:
                const Text("Failed to get your messages. Try again after."),
          );
        },
      );
    }
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
            'Your messages',
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
              const Padding(
                  padding: EdgeInsets.only(top: 10)), // separation form the top
              for (var i in myMessages) Message.fromMap(i)
            ], // for each offer, we create and display a card
          ),
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
                      icon: const Icon(Icons.mail,
                          color: const Color(0xFF2A8600)),
                      onPressed: () {})),
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
