import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'globalVar.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter/cupertino.dart';

class offerDetails extends StatefulWidget {
  List<String> offerDetailsList = [];

  offerDetails(this.offerDetailsList, {Key? key}) : super(key: key);

  @override
  State<offerDetails> createState() => _offerDetails(offerDetailsList);
}

// this class builds the details of a certain offer
class _offerDetails extends State<offerDetails> {
  // ATTRIBUTES
  List<String> offerDetailsList = [];
  String title = "default";
  // ignore: non_constant_identifier_names
  String best_before = "default";
  String distance = "default";
  //default image
  String image = "default";
  String city = "default"; //todo
  String description = "default";
  bool reserved = false; //default

  // BUILDER METHOD
  // we set the attributes of the offer
  _offerDetails(List<String> offerDetailsList) {
    this.offerDetailsList = offerDetailsList;
    title = offerDetailsList.elementAt(3);
    best_before = offerDetailsList.elementAt(7);
    distance = "1.5 km"; // todo
    this.city = "Deventer"; //todo
    image = offerDetailsList.elementAt(5);
    description = offerDetailsList.elementAt(4);
    reserved = false; //default
    checkIfReserved(); //todo: check if reserved or not
  }

  //todo
  void reserve() {
    //todo -> call to backend
    _showReservationConfirmationDialog();
  }

  //todo
  void cancelReservation() {}

  //todo: need to check if this item is already reserved by the active user to
  //show the corresponding navigation bar (reserve or cancel reservation)
  void checkIfReserved() {}

  // shows the reservation confirmation
  Future<void> _showReservationConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)), //make alert rounded
          backgroundColor: const Color.fromARGB(237, 244, 242, 221),
          title: const Text(
            'Reserve the item',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'You will recieve a notification if your reservation is accepted.'),
                Text('Reserve?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Approve',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showAnimationOfReservationDialog();
              },
            ),
          ],
        );
      },
    );
  }

  // shows that the reservation has succesfully happened
  Future<void> _showAnimationOfReservationDialog() async {
    Timer _timer;
    _timer = Timer(Duration(seconds: 1), () {
      //to autoclose the dialog
      Navigator.of(context).pop();
      // todo: recharge page so the navigation bar changes to cancel reservation
    });

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)), //make alert rounded
          backgroundColor: const Color.fromARGB(237, 244, 242, 221),
          content: SingleChildScrollView(
            child: Column(
              children: const [
                Icon(CupertinoIcons.gift, size: 150, color: Colors.grey),
                Text(
                  "Reserved",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
    ;
  }

  // depending on if the user already reserved this element, we need to show a different option in the navigation bar
  Widget _NavBar() {
    if (!reserved) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
        child: SizedBox(
          height: 50, //make the button bigger
          child: TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF7F9946)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), //rounded corners of the button
                ))),
            onPressed: () => {
              reserve(),
              setState(() {
                reserved = true;
              })
            },
            child: const Text(
              "Reserve",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
      child: SizedBox(
        height: 50, //make the button bigger
        child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 245, 52, 35)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), //rounded corners of the button
              ))),
          onPressed: () => {
            cancelReservation(),
            setState(() {
              reserved = false;
            })
          },
          child: const Text(
            "Cancel reservation",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }

  //displays all the information of the offer
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: _NavBar(),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(FontAwesome.angle_left),
            onPressed: () => Navigator.pop(context, false),
          ), // different arroy style to fit with the prototype
          title: const Text(
            'Back',
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(112, 244, 242, 221),
        ),
        //backgroundColor: const Color(0xFFF4F2DD),
        body: SingleChildScrollView(
          // to avoid overfloww
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
                CrossAxisAlignment.start, // so the text starts at the left
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 38)),
              Image.network(
                //image
                //first we load the image
                image,
              ),
              Padding(
                // title
                //some space between the image and the title
                padding: const EdgeInsets.all(15.0),
                child: Text(title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                    )),
              ),
              Padding(
                // location
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesome.map_pin,
                      size: 15,
                    ),
                    Text("   " +
                        city +
                        "    "), // putting some distance between the icon and the location
                    Text(
                      "(" + distance + ")",
                      style: const TextStyle(
                          fontFamily: 'JosefinSans', color: Colors.grey),
                    )
                  ],
                ),
              ),
              Padding(
                // date best before
                padding: const EdgeInsets.only(left: 15.0, top: 7),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesome.calendar,
                      size: 15,
                    ),
                    Text("   " +
                        best_before +
                        "    "), // putting some distance between the icon and the location
                    const Text(
                      "(best before)",
                      style: TextStyle(
                          fontFamily: 'JosefinSans', color: Colors.grey),
                    )
                  ],
                ),
              ),
              const Padding(
                //divider
                // divider of the text (grey line)
                padding:
                    EdgeInsets.only(top: 8.0, left: 15, right: 15, bottom: 8.0),
                child: Divider(
                  thickness: 1.5,
                ),
              ),
              Padding(
                //description of the product
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
