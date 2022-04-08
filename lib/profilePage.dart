import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/homePage.dart';
import 'package:flutter_assignment2/myOffers.dart';
import 'User.dart';
import 'globalVar.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter/cupertino.dart';

class profilePage extends StatefulWidget {
  profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePage();
}

// this class builds the details of a certain offer
class _profilePage extends State<profilePage> {
  //Atributes
  Map<String, dynamic> userDetails = {};
  List<Map<String, dynamic>> friends = [];

  // Constructor method
  _profilePage() {
    this.userDetails = globals.users; //todo: implement call to api
    this.friends = globals.friends; //todo: implement call to api
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              color: Color(0xFFF9F9F9),
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
                          icon: const Icon(Icons.favorite), onPressed: () {})),
                  Expanded(
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
                      child: IconButton(
                          icon: const Icon(Icons.mail), onPressed: () {})),
                  Expanded(
                      child: IconButton(
                          icon: const Icon(Icons.person), onPressed: () {})),
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
                    const Padding(padding: const EdgeInsets.only(top: 10)),
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
