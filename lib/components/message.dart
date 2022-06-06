import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/messages_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_assignment2/global_var.dart' as globals;

// Returns all the objects offered in a certain area formatted as cards
class Message extends StatelessWidget {
  String imageOfOffer = "default";
  String imageOfSolicitor = "default";
  String solicitorName = "Tatiana";
  String offerId = "1";
  String id = "";

  Message({
    Key? key,
    required this.id,
    required this.imageOfOffer,
    required this.imageOfSolicitor,
    required this.solicitorName,
    required this.offerId,
  }) : super(key: key);

  // Builds a message from a map
  Message.fromMap(Map<String, dynamic> message, {Key? key}) : super(key: key) {
    id = message["id"];
    imageOfOffer = message["imageOfOffer"];
    imageOfSolicitor = message["imageOfSolicitor"];
    solicitorName = message["solicitorName"];
    offerId = message["offerId"];
  }

  //Accepts the offer to reserve the product
  Future<void> acceptOffer(BuildContext context) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/user/requests/' + id),
      headers: <String, String>{
        'Authorization': 'Bearer ' + globals.accessToken,
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode(<String, String>{
        'accepted': 'True',
      }),
    );

    if (response.statusCode == 200) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            content: const Text("Accepted!"),
          );
        },
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MessagesPage()));
    } else {
      // If the server did not return a 200 response,
      // then throw an exception.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            content:
                const Text("Could not accept. Please retry in some moments."),
          );
        },
      );
    }
  }

  //Declines the offer to reserve the product
  void declineOffer(BuildContext context) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/user/requests/' + id),
      headers: <String, String>{
        'Authorization': 'Bearer ' + globals.accessToken,
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode(<String, String>{
        'accepted': 'False',
      }),
    );

    if (response.statusCode == 200) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            content: const Text("Canceled"),
          );
        },
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MessagesPage()));
    } else {
      // If the server did not return a 200 response,
      // then throw an exception.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            content:
                const Text("Could not decline. Please retry in some moments."),
          );
        },
      );
    }
  }

  @override
  // the container of a card: it is a text button showing image, distance and best before date
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: const Color.fromARGB(237, 244, 242, 221),
      child: Column(
        children: [
          Image.network(
            imageOfOffer,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 10)),
              CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    imageOfSolicitor,
                  )),
              const Padding(
                  padding: EdgeInsets.only(
                      left: 35)), //space between picture and name
              Column(
                children: [
                  Text(
                    solicitorName,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      declineOffer(context);
                    },
                    child: const Text('Decline'),
                  ),
                  TextButton(
                    onPressed: () {
                      acceptOffer(context);
                    },
                    child: const Text(
                      'Accept',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
