import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/home_page.dart';
import 'package:flutter_assignment2/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_assignment2/global_var.dart' as globals;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

// this class shows the register page
class _RegisterPage extends State<RegisterPage> {
  //Atributes
  //the controlers are useful to retrieve the tect from the text fields
  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();
  final myControllerPassword2 = TextEditingController();

  // Calls the API to register the new user and it handles the errors
  Future<void> validateSignUp(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/register/'),
      body: jsonEncode(<String, String>{
        'username': myControllerUsername.text.toString().trim(),
        'password1': myControllerPassword.text.toString().trim(),
        'password2': myControllerPassword.text.toString().trim(),
        'first_name': 'default',
        'last_name': 'default',
      }),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      globals.accessToken = data['access_token'];
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            content: const Text(
                "There has been an error, wait some time and try again"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    top: 120.0, left: 100, right: 100, bottom: 30),
                child: Image(
                  width: 100,
                  image: AssetImage("images/appvocado-loading.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                child: TextFormField(
                  controller: myControllerUsername,
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 134, 0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 42, 134, 0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
                child: TextFormField(
                  controller: myControllerPassword,
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 134, 0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 42, 134, 0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
                child: TextFormField(
                  controller: myControllerPassword2,
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Repeat password',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 134, 0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 42, 134, 0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), //rounded corners of the button
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFCBD781)),
                      foregroundColor:
                          MaterialStateProperty.all(const Color(0xFF2A8600))),
                  onPressed: () {
                    // Respond to button press
                    if (myControllerPassword.text == "" ||
                        myControllerUsername.text == "" ||
                        myControllerPassword2.text == "") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0)), //make alert rounded
                            backgroundColor:
                                const Color.fromARGB(237, 244, 242, 221),
                            // Retrieve the text that the user has entered by using the
                            // TextEditingController.
                            content: const SizedBox(
                              height: 60,
                              width: 40,
                              child: Center(
                                child: Text(
                                  "Fill all the required fields",
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (myControllerPassword
                            .text != //if passwords are not the same
                        myControllerPassword2.text) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0)), //make alert rounded
                            backgroundColor:
                                const Color.fromARGB(237, 244, 242, 221),
                            // Retrieve the text that the user has entered by using the
                            // TextEditingController.
                            content: const SizedBox(
                              height: 60,
                              width: 40,
                              child: Center(
                                child: Text(
                                  "Passwords do not match",
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      validateSignUp(context);
                    }
                  },
                  child: const Text('Create account'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
