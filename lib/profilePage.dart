import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/homePage.dart';
import 'globalVar.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter/cupertino.dart';

class profilePage extends StatefulWidget {
  Map<String, dynamic> userDetails = {};

  profilePage(this.userDetails, {Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePage(userDetails);
}

// this class builds the details of a certain offer
class _profilePage extends State<profilePage> {
  //Atributes
  Map<String, dynamic> userDetails = {};
  String image = "";
  _profilePage(Map<String, dynamic> userDetails) {
    this.userDetails = userDetails; //todo: implement call to api
    image = userDetails["picture"];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: IconButton(
                    icon: const Icon(Icons.travel_explore),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                  )),
                  Expanded(
                      child: IconButton(
                          icon: const Icon(Icons.favorite), onPressed: () {})),
                  Expanded(
                    child: IconButton(
                        icon: const Icon(FontAwesome.food), onPressed: () {}),
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
              child: Column(
                children: [Image.network(image)],
              ),
            )));
  }
}
