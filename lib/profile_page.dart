import 'package:flutter/material.dart';
import 'package:flutter_assignment2/favorites_page.dart';
import 'package:flutter_assignment2/home_page.dart';
import 'package:flutter_assignment2/messages_page.dart';
import 'package:flutter_assignment2/my_offers.dart';
import 'user.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'global_var.dart' as globals;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

// this class builds the details of a certain offer
class _ProfilePage extends State<ProfilePage> {
  //Atributes
  Map<String, dynamic> userDetails = {};
  List<Map<String, dynamic>> friends = [];

  _ProfilePage() {
    userDetails = globals.users; //todo: implement call to api
    friends = globals.friends; //todo: implement call to api
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
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(userDetails["picture"]),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      userDetails["name"], //name of user
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesome.map_pin,
                          size: 15,
                        ),
                        Text(
                          userDetails["location"], //location of user
                          style: const TextStyle(
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
