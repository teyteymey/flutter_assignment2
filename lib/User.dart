// ignore: file_names
import 'package:flutter/material.dart';

Widget userCard(Map<String, dynamic> userDetails) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    color: const Color.fromARGB(237, 244, 242, 221),
    child: Row(
      children: [
        CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
              userDetails["picture"],
            )),
        const Padding(
            padding:
                EdgeInsets.only(left: 35)), //space between picture and name
        Column(
          children: [
            Text(
              userDetails["name"],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            )
          ],
        )
      ],
    ),
  );
}
