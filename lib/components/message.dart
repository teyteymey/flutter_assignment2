import 'package:flutter/material.dart';

// Returns all the objects offered in a certain area formatted as cards
// ignore: must_be_immutable
class Message extends StatelessWidget {
  String imageOfOffer = "default";
  String imageOfSolicitor = "default";
  String solicitorName = "Tatiana";
  String offerId = "1";

  Message({
    Key? key,
    required this.imageOfOffer,
    required this.solicitorName,
    required this.offerId,
  }) : super(key: key);

  // Builds a message from a map
  Message.fromMap(Map<String, dynamic> message, {Key? key}) : super(key: key) {
    imageOfOffer = message["imageOfOffer"];
    imageOfSolicitor = message["imageOfSolicitor"];
    solicitorName = message["solicitorName"];
    offerId = message["offerId"];
  }
  //TODO
  void acceptOffer() {}
  //TODO
  void declineOffer() {}

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
                      declineOffer();
                    },
                    child: const Text('Decline'),
                  ),
                  TextButton(
                    onPressed: () {
                      acceptOffer();
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
