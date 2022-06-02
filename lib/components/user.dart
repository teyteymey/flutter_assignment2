// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global_var.dart' as globals;

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

Future<String> getNameUserById(String id) async {
  final responseUser = await http.get(
      Uri.parse('http://10.0.2.2:8000/user/' + id + '/'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + globals.accessToken,
      });

  if (responseUser.statusCode == 200) {
    final data = jsonDecode(responseUser.body);
    return data['first_name'];
  } else {
    throw Exception('Failed to get user.');
  }
}
