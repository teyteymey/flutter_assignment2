import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/favorites_page.dart';
import 'package:flutter_assignment2/pages/home_page.dart';
import 'package:flutter_assignment2/pages/messages_page.dart';
import 'package:flutter_assignment2/pages/my_offers_page.dart';
import '../components/user.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import '../global_var.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

// this class shows the profile of the logged in user
class _ProfilePage extends State<ProfilePage> {
  //Atributes
  Map userDetails = {};
  List<Map<String, dynamic>> friends = globals.friends;
  String username = 'def';

  @override
  void initState() {
    getDataLoggedUser().then((value) {
      print('Async done');
    });
    super.initState();
  }

  _ProfilePage() {}

  // Call to the API to get the name of the logged in user
  Future getDataLoggedUser() async {
    final responseUser = await http
        .get(Uri.parse('http://10.0.2.2:8000/user/'), headers: <String, String>{
      'Authorization': 'Bearer ' + globals.accessToken,
    });
    if (responseUser.statusCode == 200) {
      userDetails = await jsonDecode(responseUser.body);
      username = userDetails["username"];
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
            content: const Text("Failed to get user."),
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
            bottomNavigationBar: BottomAppBar(
              color: const Color(0xFFF9F9F9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: IconButton(
                    icon: const Icon(Icons.travel_explore),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()),
                      );
                    },
                  )),
                  Expanded(
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
                      child: IconButton(
                          icon: const Icon(Icons.person,
                              color: const Color(0xFF2A8600)),
                          onPressed: () {})),
                ],
              ),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text(
                'Profile',
                textAlign: TextAlign.center,
              ),
              backgroundColor: const Color(0xFFF4F2DD),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 40)), //space from the top
                    const CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          //NetworkImage(userDetails["picture"]),
                          NetworkImage(
                              "https://media1.popsugar-assets.com/files/thumbor/MjPiEL1c7rTUWc5qo-10Cr9DG74/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2014/11/24/864/n/1922441/8f8f3501b234abb6_FullSizeRender.jpg"),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      username, //name of user
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          FontAwesome.map_pin,
                          size: 15,
                        ),
                        Text(
                          'Deventer',
                          //userDetails["location"], //location of user
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 45)),
                    Row(
                      // friends list
                      children: const [
                        Padding(padding: EdgeInsets.only(left: 25)),
                        Text(
                          "Friends",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 100, 100, 100),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    for (var i in friends) userCard(i)
                  ],
                ),
              ),
            )));
  }
}
