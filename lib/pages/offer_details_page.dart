import 'dart:async';

import 'package:flutter/material.dart';
import '../components/user.dart';
import '../components/offer.dart';
import '../global_var.dart' as globals;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OfferDetails extends StatefulWidget {
  Offer offer;

  OfferDetails(this.offer, {Key? key}) : super(key: key);

  @override
  State<OfferDetails> createState() => _OfferDetails(offer);
}

// this class builds the details of a certain offer
class _OfferDetails extends State<OfferDetails> {
  // ATTRIBUTES
  String title = "default";
  String best_before = "default";
  String distance = "default";
  //default image
  String image = "default";
  String city = "Deventer"; //todo
  String description = "default";
  bool reserved = false; //default
  Offer offerLocal;

  // BUILDER METHOD
  // we set the attributes of the offer
  _OfferDetails(this.offerLocal) {}

  //Send a reservation request to the API
  Future<void> reserve() async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/reservations/'),
            headers: <String, String>{
              'Authorization': 'Bearer ' + globals.accessToken,
              "content-type": "application/json",
              "accept": "application/json",
            },
            body: jsonEncode(
              <String, String>{'offer_id': offerLocal.id.trim()},
            ));
    print(offerLocal.id);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      _showReservationConfirmationDialog();
    } else {
      //if the call fails, show a message to the user
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            // Retrieve the text that the user has entered by using the
            // TextEditingController.
            content: const Text("Failed to reserve."),
          );
        },
      );
    }
  }

  void cancelReservation() {}

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
    _timer = Timer(const Duration(seconds: 1), () {
      //to autoclose the dialog
      Navigator.of(context).pop();
      // todo: recharge page so the navigation bar changes to cancel reservation
    });
    setState(() {
      reserved = true;
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
  }

  // depending on if the user already reserved this element, we need to show a different option in the navigation bar
  // todo: check if logged user is the one who offers to not show reserve!
  Widget navBar() {
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
                  const Color.fromARGB(255, 245, 52, 35)),
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
        bottomNavigationBar: navBar(),
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
              // Image.network(
              //   //image
              //   //first we load the image
              //   offerLocal.image,
              // ),
              Image.network(
                  'https://www.boodschappen.nl/app/uploads/2018/09/Header_iStock-537514836-780x520.jpg'),
              Padding(
                // title
                //some space between the image and the title
                padding: const EdgeInsets.all(15.0),
                child: Text(offerLocal.title,
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
                        offerLocal.endDate +
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
                  offerLocal.description,
                  textAlign: TextAlign.justify,
                ),
              ),
              const Padding(
                //divider
                // divider of the text (grey line)
                padding: EdgeInsets.only(top: 8.0, left: 15, right: 15),
                child: Divider(
                  thickness: 1.5,
                ),
              ),
              userCard(globals.users) //todo: pass info of the user
            ],
          ),
        ),
      ),
    );
  }
}
