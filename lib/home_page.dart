import 'package:flutter/material.dart';
import 'package:flutter_assignment2/my_offers.dart';
import 'package:flutter_assignment2/profile_page.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'offer.dart';
import 'global_var.dart' as globals;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              for (var i in globals.allOffers) Offer.fromMap(i)
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
                        MaterialPageRoute(
                            builder: (context) => const MyOffers()),
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
